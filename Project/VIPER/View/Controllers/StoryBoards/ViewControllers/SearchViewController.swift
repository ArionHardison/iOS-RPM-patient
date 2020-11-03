//
//  SearchViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 12/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var searchResult : UITableView!
    @IBOutlet weak var searchCountLbl : UILabel!
    
   var searchDoctors : [Search_doctors] = [Search_doctors]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initailSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.getSearchDoctorList()
    }
    
    func initailSetup(){
        self.setupTableViewCell()
        self.searchBar.delegate = self
        self.setupNavigation()
        Common.setFont(to: self.searchCountLbl)
    }
    
    func setupNavigation(){
        
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Search Doctors"
    }
    
    
    
    // MARK:- set Multiple color for single lable
    
    func setSeatchCountLbl(resultCount : Int = 0){
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.appColor]
        
        let attributedString1 = NSMutableAttributedString(string:"Search results for Miot ", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:"(\(resultCount) results found)", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        self.searchCountLbl.attributedText = attributedString1
    }
    
}



extension SearchViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.setSeatchCountLbl(resultCount: self.searchDoctors.count)
        return self.searchDoctors.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.SearchCell) as! SearchCell
        if let search : Search_doctors  = self.searchDoctors[indexPath.row]{
            cell.docNameLbl.text = search.first_name
            cell.docDegreeLbl.text = search.doctor_profile?.certification ?? ""
            cell.docSpecialtLbl.text = search.doctor_profile?.speciality?.name ?? ""
            cell.docImage.setURLImage(search.doctor_profile?.profile_pic ?? "")
        }
//        self.SearchCellAction(cell: cell)
        return cell
        
    }
    
    func SearchCellAction(cell : SearchCell,indexPathForID:String?){
        cell.contentView.addTap {
//            doctorId = cell.
            self.push(id: Storyboard.Ids.DoctorDetailsController, animation: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let search : Search_doctors  = self.searchDoctors[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.DoctorDetailsController) as! DoctorDetailsController
        vc.docProfile = search.doctor_profile ?? Doctor_profile()
        vc.isFromSearchDoctor = true
        vc.searchDoctor = search
        doctorId = "\(search.id ?? 0)"
        serviceID = "\(search.services_id ?? "0")"
        self.navigationController?.pushViewController(vc, animated: true)
        
        
//        self.push(id: Storyboard.Ids.DoctorDetailsController, animation: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func setupTableViewCell(){
        self.searchResult.registerCell(withId: XIB.Names.SearchCell)
    }
    
}



//Api calls
extension SearchViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.DoctorsListModel:
                let data = dataDict as? DoctorsListModel
                self.searchDoctors = data?.search_doctors ?? [Search_doctors]()
                DispatchQueue.main.async {
                    self.searchResult.reloadInMainThread()
                }
                
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getSearchDoctorList(){
        self.presenter?.HITAPI(api: Base.searchDoctors.rawValue, params: nil, methodType: .GET, modelClass: DoctorsListModel.self, token: true)
    }
    
}



// #MARK:- Search Functionality


extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty{

              self.presenter?.HITAPI(api: Base.searchDoctors.rawValue + "?search=\(searchText)", params: nil, methodType: .GET, modelClass: DoctorsListModel.self, token: true)
            
        }
        
    }

    
}
