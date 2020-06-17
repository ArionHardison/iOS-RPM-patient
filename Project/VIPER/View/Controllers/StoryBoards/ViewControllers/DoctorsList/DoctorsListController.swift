//
//  DoctorsListController.swift
//  Project
//
//  Created by Chan Basha on 24/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class DoctorsListController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var doctorsListTV: UITableView!
    
    var doctorProfile : [Doctor_profile] = [Doctor_profile]()
    
    var catagoryID : Int  = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initilaLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.getDoctorsList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            self.navigationController?.navigationBar.isHidden = false
    }
     
    private func initilaLoads(){
        
   
        doctorsListTV.register(UINib(nibName: XIB.Names.DoctorCell, bundle: .main), forCellReuseIdentifier:  XIB.Names.DoctorCell)
        self.btnBack.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)

    }
    
    
       
}

extension DoctorsListController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.doctorProfile.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.DoctorCell, for: indexPath) as! DoctorCell
        self.doctorCellAction(cell: cell, detail: self.doctorProfile[indexPath.row])
        self.populateCell(cell: cell, detail: self.doctorProfile[indexPath.row])
        return cell
    }
    
    func populateCell(cell : DoctorCell , detail : Doctor_profile){
        cell.docterImage.setURLImage(detail.profile_pic ?? "")
        cell.docterName.text = "\(detail.hospital?[0].first_name ?? "") \(detail.hospital?[0].last_name ?? "")"
        cell.SplistLbl.text = detail.speciality?.name ?? ""
        cell.availablityLbl.text = "Available \(detail.hospital?[0].availability ?? "")"
        cell.clinicNameLbl.text = detail.hospital?[0].clinic?.name ?? ""
        cell.likeCountLbl.text = "\(detail.hospital?[0].feedback_percentage ?? "0") %"
        cell.feeLbl.text = "$ "+(detail.fees ?? 0).description
    }
    
    
    func doctorCellAction(cell : DoctorCell  , detail : Doctor_profile){
        cell.docterImage.addTap {
            let vc = DoctorDetailsController.initVC(storyBoardName: .main, vc: DoctorDetailsController.self, viewConrollerID:  Storyboard.Ids.DoctorDetailsController)
            vc.docProfile = detail
            self.push(from: self, ToViewContorller: vc)
        }
        
        cell.callBtn.addTap {
            if let url = URL(string: "tel://\(detail.hospital?[0].mobile ?? "")"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        
        cell.bookingBtn.addTap{
        let vc = BookingViewController.initVC(storyBoardName: .main, vc: BookingViewController.self, viewConrollerID: Storyboard.Ids.BookingViewController)
        vc.docProfile = detail
        self.push(from: self, ToViewContorller: vc)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    

    
    
}


//Api calls
extension DoctorsListController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.DoctorsDetailModel:
                 let data = dataDict as? DoctorsDetailModel
                 self.doctorProfile = data?.specialities?.doctor_profile ?? [Doctor_profile]()
                 self.doctorsListTV.reloadData()
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getDoctorsList(){
        self.presenter?.HITAPI(api: Base.catagoryList.rawValue+"/\(self.catagoryID ?? 0)", params: nil, methodType: .GET, modelClass: DoctorsDetailModel.self, token: true)
    }
    
    func cancelAppointment(id : String){
        self.presenter?.HITAPI(api: Base.cancelAppointment.rawValue, params: ["id" : id], methodType: .POST, modelClass: CommonModel.self, token: true)
    }
}
