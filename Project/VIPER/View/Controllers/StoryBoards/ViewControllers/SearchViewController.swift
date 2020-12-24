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
    var isUpdate : Bool = false
    var isFromSearch : Bool = false
    lazy var loader : UIView = {
        return createActivityIndicator(self.view.window ?? self.view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initailSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.getSearchDoctorList(count: 0)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.isUpdate = false
        self.isFromSearch = false
        self.searchDoctors.removeAll()
    }
    
    func initailSetup(){
        self.setupTableViewCell()
        self.searchBar.delegate = self
        self.setupNavigation()
        Common.setFontWithType(to: self.searchCountLbl, size: 14, type: .regular)
    }
    
    func setupNavigation(){
        
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Search Doctors"
    }
    
    
    
    // MARK:- set Multiple color for single lable
    
    func setSeatchCountLbl(resultCount : Int = 0){
        let attrs1 = [NSAttributedString.Key.font : UIFont.init(name: FontCustom.regular.rawValue, size: 14), NSAttributedString.Key.foregroundColor : UIColor(named: "TextBlackColor")]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.init(name: FontCustom.regular.rawValue, size: 14), NSAttributedString.Key.foregroundColor : UIColor(named: "AppBlueColor")]
        
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
         let search : Search_doctors  = self.searchDoctors[indexPath.row]
        cell.docNameLbl.text = search.first_name?.capitalized
        cell.docDegreeLbl.text = search.doctor_profile?.certification ?? "".uppercased()
        cell.docSpecialtLbl.text = search.doctor_profile?.speciality?.name ?? "".capitalized
            cell.docImage.setURLImage(search.doctor_profile?.profile_pic ?? "")
        
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
        vc.searchDoctor = search
        vc.isFromSearchDoctor = true
        vc.categoryID = Int(search.services_id ?? "0") ?? 1
        doctorId = "\(search.id ?? 0)"
        serviceID = "\(search.services_id ?? "0")"
        self.navigationController?.pushViewController(vc, animated: true)
        
        
//        self.push(id: Storyboard.Ids.DoctorDetailsController, animation: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    
    func setupTableViewCell(){
        self.searchResult.registerCell(withId: XIB.Names.SearchCell)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.searchDoctors.count >= 10 {
            if !isFromSearch{
        if indexPath.row == self.searchDoctors.count - 3{
            isUpdate = true
            let count = self.searchDoctors[self.searchDoctors.count - 1].id ?? 0
            self.getSearchDoctorList(count: count)
            
        }
    }
        }
    }
}



//Api calls
extension SearchViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.DoctorsListModel:
                self.loader.isHideInMainThread(true)
                let data = dataDict as? DoctorsListModel
                if !isUpdate{
                self.searchDoctors = data?.search_doctors ?? [Search_doctors]()
                }else{
                    if !isFromSearch{
                    for i in 0...((data?.search_doctors?.count ?? 0)){
                        if i == 10{
                        guard let data = data?.search_doctors?[i - 1] else { return  }
//                        self.searchDoctors.append(data)
                        }else{
                            guard let data = data?.search_doctors?[i] else { return  }
                            self.searchDoctors.append(data)
                        }
                    }
                    }else{
                        self.searchDoctors = data?.search_doctors ?? []
                    }
                   
                }
                DispatchQueue.main.async {
                    self.searchResult.reloadInMainThread()
                }
                
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getSearchDoctorList(count:Int){
//        var params = [String:Any]()
//        params.updateValue("\(count)", forKey: "page")
        let url = "\(Base.searchDoctors.rawValue)?page=\(count)"
        self.presenter?.HITAPI(api:url, params: nil, methodType: .GET, modelClass: DoctorsListModel.self, token: true)
        if count > 1 {
            
        }else{
        self.loader.isHidden = false
        }
    }
    
}



// #MARK:- Search Functionality


extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty{
            DispatchQueue.main.async {
                self.presenter?.HITAPI(api: Base.searchDoctors.rawValue + "?search=\(searchText)", params: nil, methodType: .GET, modelClass: DoctorsListModel.self, token: true)
                self.isFromSearch = true
            }
          
            
        }
        
    }

    
}
