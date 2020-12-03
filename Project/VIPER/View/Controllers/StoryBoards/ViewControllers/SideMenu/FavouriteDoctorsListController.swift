//
//  FavouriteDoctorsListController.swift
//  Project
//
//  Created by Chan Basha on 23/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class FavouriteDoctorsListController: UIViewController {

    @IBOutlet var listTable : UITableView!
    
    var favouriteDoctors : [Favourite_Doctors] = [Favourite_Doctors]()
    
    lazy var loader  : UIView = {
        return createActivityIndicator(self.view.window ?? self.view)
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.getFavDoctorList()
    }
    
    

}

extension FavouriteDoctorsListController {
    
    func initialLoads() {
        registerCell()
        setupNavigationBar()

    }
    private func setupNavigationBar() {
         self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Favourite Doctors"
         Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
         self.navigationController?.navigationBar.isTranslucent = false
         self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
    }

    func registerCell(){
        self.listTable.registerCell(withId: XIB.Names.FavDoctorTableViewCell)
        
        self.listTable.tableFooterView = UIView()
    }
}

extension FavouriteDoctorsListController : UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favouriteDoctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.listTable.dequeueReusableCell(withIdentifier: XIB.Names.FavDoctorTableViewCell, for: indexPath) as! FavDoctorTableViewCell
        self.populateCell(cell: cell, data: self.favouriteDoctors[indexPath.row])
        return cell
    }
    
    func populateCell(cell : FavDoctorTableViewCell , data : Favourite_Doctors){
        cell.doctorImage.setURLImage(data.hospital?.doctor_profile?.profile_pic ?? "")
        cell.labelName.text = data.hospital?.first_name ?? ""
        cell.labelSpeciality.text = data.hospital?.doctor_profile?.speciality?.name ?? ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.DoctorDetailsController) as! DoctorDetailsController
        vc.isFromSearchDoctor = false
        vc.isfromFavourite = true
        vc.favouriteDoctor = self.favouriteDoctors[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
//        self.push(id: Storyboard.Ids.DoctorDetailsController, animation: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
 


//Api calls
extension FavouriteDoctorsListController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.DoctorsListModel:
                self.loader.isHideInMainThread(true)
                let data = dataDict as? DoctorsListModel
                self.favouriteDoctors = data?.favourite_Doctors ?? [Favourite_Doctors]()
                self.listTable.reloadData()
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getFavDoctorList(){
        self.presenter?.HITAPI(api: Base.searchDoctors.rawValue, params: nil, methodType: .GET, modelClass: DoctorsListModel.self, token: true)
        self.loader.isHidden = false
    }
    
}
