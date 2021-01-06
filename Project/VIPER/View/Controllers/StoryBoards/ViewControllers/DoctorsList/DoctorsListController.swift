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
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var filterImageButton: UIButton!
    
    var doctorProfile : [Doctor_profile] = [Doctor_profile]()
    
    var catagoryID : Int  = -1
    var isUpdate : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initilaLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getDoctorsList(count: 0)
        self.navigationController?.navigationBar.isHidden = true
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            self.navigationController?.navigationBar.isHidden = false
        self.doctorProfile.removeAll()
        self.isUpdate = false
    }
       
}

extension DoctorsListController {
    private func initilaLoads(){
        
   
        doctorsListTV.register(UINib(nibName: XIB.Names.DoctorCell, bundle: .main), forCellReuseIdentifier:  XIB.Names.DoctorCell)
        self.btnBack.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
//        self.filterImageButton.addTarget(self, action: #selector(filterAction(sender:)), for: .touchUpInside)
        self.filterImageButton.addTarget(self, action: #selector(filterAction(sender:)), for: .touchUpInside)
     

    }
//    @IBAction private func filterAction(sender:UIButton){
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.FilterViewController) as! FilterViewController
//        vc.modalTransitionStyle = .coverVertical
//        vc.modalPresentationStyle = .fullScreen
//        vc.onClickDone = { (availablity,gender,price) in
//            let url = "/api/patient/doctor_catagory/\(self.catagoryID)?availability_type=\(availablity)&gender=\(gender)&fees=\(price)"
//            self.presenter?.HITAPI(api: url, params: nil, methodType: .GET, modelClass: DoctorsDetailModel.self, token: true)
//            vc.dismiss(animated: true, completion: nil)
//
//
//        }
//        self.navigationController?.present(vc, animated: true, completion: nil)
//    }
    @IBAction private func filterAction(sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.FilterViewController) as! FilterViewController
        vc.onClickDone = { (availablity,gender,price) in
            if availablity == "AvailableAllDAY"{
                let url = "/api/patient/doctor_catagory/\(self.catagoryID)?gender=\(gender)&fees=\(price)"
                self.presenter?.HITAPI(api: url, params: nil, methodType: .GET, modelClass: DoctorsDetailModel.self, token: true)
                self.isUpdate = false
            }else{
            let url = "/api/patient/doctor_catagory/\(self.catagoryID)?availability_type=\(availablity)&gender=\(gender)&fees=\(price)"
            self.presenter?.HITAPI(api: url, params: nil, methodType: .GET, modelClass: DoctorsDetailModel.self, token: true)
            }
            self.isUpdate = false
            vc.dismiss(animated: true, completion: nil)


        }
        let navController = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
}

extension DoctorsListController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.doctorProfile.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.DoctorCell, for: indexPath) as! DoctorCell
        self.doctorCellAction(cell: cell, detail: self.doctorProfile[indexPath.row])
        if self.doctorProfile[indexPath.row].hospital?.count != 0  {
            self.populateCell(cell: cell, detail: self.doctorProfile[indexPath.row])

        }
        return cell
    }
    
    func populateCell(cell : DoctorCell , detail : Doctor_profile){
        cell.docterImage.setURLImage(detail.profile_pic ?? "")
        cell.docterName.text = "\(detail.hospital?[0].first_name ?? "") \(detail.hospital?[0].last_name ?? "")"
        cell.SplistLbl.text = detail.speciality?.name ?? ""
        cell.availablityLbl.text = "\(detail.hospital?[0].availability ?? "Available Today")"
        cell.clinicNameLbl.text = "\(detail.hospital?[0].clinic?.name ?? ""),\(detail.hospital?[0].clinic?.address ?? "No Address Found")"
        cell.likeCountLbl.text = "\(detail.hospital?[0].feedback_percentage ?? "0") %"
        cell.feeLbl.text = "$"+"\(detail.fees ?? 0)"
    }
    
    
    func doctorCellAction(cell : DoctorCell  , detail : Doctor_profile){
        cell.docterImage.addTap {
            let vc = DoctorDetailsController.initVC(storyBoardName: .main, vc: DoctorDetailsController.self, viewConrollerID:  Storyboard.Ids.DoctorDetailsController)
            vc.docProfile = detail
            vc.isFromSearchDoctor = false
            vc.categoryID = self.catagoryID
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
         vc.isFromSearch = false
            vc.categoryId = self.catagoryID
        self.push(from: self, ToViewContorller: vc)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DoctorDetailsController.initVC(storyBoardName: .main, vc: DoctorDetailsController.self, viewConrollerID:  Storyboard.Ids.DoctorDetailsController)
        vc.docProfile = self.doctorProfile[indexPath.row]
        vc.isFromSearchDoctor = false
        self.push(from: self, ToViewContorller: vc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.doctorProfile.count >= 10{
        if indexPath.row == (self.doctorProfile.count - 3){
            isUpdate = true
            let count = self.doctorProfile[self.doctorProfile.count - 1].doctor_id ?? 0
            self.getDoctorsList(count: count)
        }
    }
    }
        
}


//Api calls
extension DoctorsListController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.DoctorsDetailModel:
                
                 let data = dataDict as? DoctorsDetailModel
//                 self.doctorProfile = data?.specialities?.doctor_profile ?? [Doctor_profile]()
                if !isUpdate{
                    self.doctorProfile = data?.specialities?.doctor_profile ?? [Doctor_profile]()
//                self.searchDoctors = data?.search_doctors ?? [Search_doctors]()
                }else{
                    if data?.specialities?.doctor_profile?.count ?? 0 > 0{
                    for i in 0...((data?.specialities?.doctor_profile?.count ?? 0)){
//                        self.doctorProfile.append(data?.specialities?.doctor_profile?[i] ?? <#default value#>)
//                        if i == 10{
                        guard let data = data?.specialities?.doctor_profile?[i - 1] else { return  }
                        self.doctorProfile.append(data)
                    }
                }
                }
//                        self.searchDoctors.append(data)
//                        }else{
//                            guard let data = data?.specialities?.doctor_profile?[i] else { return  }
//                            self.doctorProfile.append(data)
//                        }
//                    }
                   
//                }
                 self.doctorsListTV.reloadData()
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getDoctorsList(count:Int){
        let url = Base.catagoryList.rawValue+"/\(self.catagoryID )?page=\(count)"
        self.presenter?.HITAPI(api: url, params: nil, methodType: .GET, modelClass: DoctorsDetailModel.self, token: true)
    }
    
    func cancelAppointment(id : String){
        self.presenter?.HITAPI(api: Base.cancelAppointment.rawValue, params: ["id" : id], methodType: .POST, modelClass: CommonModel.self, token: true)
    }
}
