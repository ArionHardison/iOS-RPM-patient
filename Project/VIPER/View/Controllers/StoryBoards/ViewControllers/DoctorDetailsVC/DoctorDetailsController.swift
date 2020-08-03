//
//  DoctorDetailsController.swift
//  Project
//
//  Created by Chan Basha on 04/05/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class DoctorDetailsController: UIViewController {
    
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var imgDoctor: UIImageView!
    @IBOutlet weak var labelDoctorName: UILabel!
    @IBOutlet weak var labelSpeciality: UILabel!
    @IBOutlet weak var labelQualification: UILabel!
    @IBOutlet weak var labelPercentage: UILabel!
    @IBOutlet weak var labelExp: UILabel!
    @IBOutlet weak var labelVerified: UILabel!
    @IBOutlet weak var labelAvailability: UILabel!
    @IBOutlet weak var labelMonday: UILabel!
    @IBOutlet weak var labelTue: UILabel!
    @IBOutlet weak var labelWed: UILabel!
    @IBOutlet weak var labelThu: UILabel!
    @IBOutlet weak var labelFri: UILabel!
    @IBOutlet weak var labelSat: UILabel!
    @IBOutlet weak var labelSun: UILabel!
    @IBOutlet weak var labelServices: UILabel!
    @IBOutlet weak var servicesTV: UITableView!
    @IBOutlet weak var labelSpecilization: UILabel!
    @IBOutlet weak var specilizationTV: UITableView!
    @IBOutlet weak var timingTableView: UITableView!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelClinicName: UILabel!
    @IBOutlet weak var labelLocationValue: UILabel!
    @IBOutlet weak var imgLocationPreview: UIImageView!
    @IBOutlet weak var labelPhotos: UILabel!
    @IBOutlet weak var photosCV: UICollectionView!
    @IBOutlet weak var labelReviews: UILabel!
    @IBOutlet weak var reviewsCV: UICollectionView!
    @IBOutlet weak var specilizationTVHeight: NSLayoutConstraint!
    @IBOutlet weak var serviceTVHeight: NSLayoutConstraint!
    @IBOutlet weak var timingHeight: NSLayoutConstraint!
    
    //inital static Data
    
    var docProfile : Doctor_profile = Doctor_profile()
    
    var speciality : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //View Setup
        self.initialLoads()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.populateData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.specilizationTVHeight.constant = self.specilizationTV.contentSize.height + 10
        self.serviceTVHeight.constant = self.servicesTV.contentSize.height + 10
        self.timingHeight.constant = self.timingTableView.contentSize.height + 10
    }
    
    
    func populateData(){
        if let detail : Hospital = self.docProfile.hospital?[0]{
            self.labelDoctorName.text = "\(detail.first_name ?? "") \(detail.last_name ?? "")"
            self.imgDoctor.setURLImage(detail.doctor_profile?.profile_pic ?? "")
             self.imgDoctor.makeRoundedCorner()
            self.labelQualification.text = "\(self.docProfile.speciality?.name ?? "")"
            self.labelPercentage.text = "\(detail.feedback_percentage ?? "") %"
            self.speciality.append(self.docProfile.speciality?.name ?? "")
         //   self.imgLocationPreview.pin_setImage(from: URL(string: detail.clinic?.static_map ?? "")!)
            self.labelClinicName.text = detail.clinic?.name ?? ""
            self.labelLocationValue.text = detail.clinic?.address ?? ""
            if (detail.is_favourite ?? "") == "false"{
                self.btnFavourite.setImage(UIImage(named: "love"), for: .normal)
            }else{
                self.btnFavourite.setImage(UIImage(named: "love_red"), for: .normal)
            }
            self.servicesTV.reloadData()
            self.specilizationTV.reloadData()
        }
    }
    
    
    func setupAction(){
        self.btnFavourite.addTap {
            self.addRemoveFav(patient_id: UserDefaultConfig.PatientID, doctor_id:(self.docProfile.id ?? 0).description)
        }
        
        self.bookBtn.addTap {
            let vc = BookingViewController.initVC(storyBoardName: .main, vc: BookingViewController.self, viewConrollerID: Storyboard.Ids.BookingViewController)
            vc.docProfile = self.docProfile
            self.push(from: self, ToViewContorller: vc)
            
        }
    }
}

extension DoctorDetailsController{
    
    private func initialLoads() {
        setupNavigationBar()
        self.setupTableViewCell()
        self.setupCollectionViewCell()
        self.setupAction()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        let shareButton = UIBarButtonItem(image: #imageLiteral(resourceName: "share").resizeImage(newWidth: 20), style: .plain, target: self, action: #selector(shareAction))
        let infoButton = UIBarButtonItem(image: #imageLiteral(resourceName: "info").resizeImage(newWidth: 20), style: .plain, target: self, action: #selector(infoAction))
        self.navigationItem.rightBarButtonItems = [shareButton,infoButton]
    }
    
    @objc func shareAction() {
        print("Share action here")
    }
    
    @objc func infoAction() {
           print("Info action here")
       }
    
}

extension DoctorDetailsController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.servicesTV{
            if (self.docProfile.hospital?[0].doctor_service?.count ?? 0) > 4{
                return 4
            }else{
                return self.docProfile.hospital?[0].doctor_service?.count ?? 0
            }
        }else if tableView == self.specilizationTV{
            if self.speciality.count > 4{
                return 4

            }else{
                return self.speciality.count
            }
             return 0
        }else if tableView == self.timingTableView{
           
            return (self.docProfile.hospital?[0].timing?.count ?? 0)
        }
        else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ServiceSpecializationCell) as! ServiceSpecializationCell
        
        if tableView == self.servicesTV{
            cell.serviceLbl.text = self.docProfile.hospital?[0].doctor_service?[indexPath.row].service?.name ?? ""
        }else if tableView == self.specilizationTV{
            cell.serviceLbl.text = self.speciality[indexPath.row]
        }else if tableView == self.timingTableView{
            if let timing : Timing = self.docProfile.hospital?[0].timing?[indexPath.row] ?? Timing(){
                cell.dotImg.isHidden = true
                self.setSeatchCountLbl(label: cell.serviceLbl, day: timing.day ?? "", timing: "\(String(describing: timing.start_time ?? "")) \(String(describing: timing.end_time ?? ""))")
            }
        }
        
        self.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = createViewAllButtion()
        footerView.addTap {
            
            self.push(id: Storyboard.Ids.ServiceListViewController, animation: true)
            
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == self.servicesTV{
            if (self.docProfile.hospital?[0].doctor_service?.count ?? 0) > 4{
                return 40
            }else{
                return 0
            }
        }else if tableView == self.specilizationTV{
            
            if speciality.count > 4{
                return 40
            }else{
                return 0
            }
          
        }
         return 0
    }
    
    func setupTableViewCell(){
        self.servicesTV.registerCell(withId: XIB.Names.ServiceSpecializationCell)
        self.specilizationTV.registerCell(withId: XIB.Names.ServiceSpecializationCell)
        self.timingTableView.registerCell(withId: XIB.Names.ServiceSpecializationCell)
    }
    
    
    func createViewAllButtion() -> UIView{
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        customView.backgroundColor = .clear
        let viewLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))

        Common.setFont(to: viewLabel,isTitle : true)
        viewLabel.text = "View all >"
        viewLabel.textAlignment = .center
        viewLabel.textColor = UIColor.appColor
        customView.addSubview(viewLabel)
        return customView
    }
    
    
    func setSeatchCountLbl(label : UILabel,day : String , timing : String){
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.red.withAlphaComponent(0.8)]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let attributedString1 = NSMutableAttributedString(string: "\(day) ", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: timing, attributes:attrs2)
        
        attributedString1.append(attributedString2)
        label.attributedText = attributedString1
    }
}


extension DoctorDetailsController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.photosCV{
            return  10
        }else if collectionView == self.reviewsCV{
            return  self.docProfile.hospital?[0].feedback?.count ?? 0
        }
        return  0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.photosCV{
            let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.Names.PhotosCell, for: indexPath) as! PhotosCell
            return photoCell
        }else if collectionView == self.reviewsCV{
            let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.Names.ReviewCell, for: indexPath) as! ReviewCell
            self.populateFeedBackData(cell: reviewCell, feedback: self.docProfile.hospital?[0].feedback?[indexPath.row] ?? Feedback())
            return reviewCell
        }
        
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.Names.PhotosCell, for: indexPath) as! PhotosCell
        return photoCell
    }
    
    func populateFeedBackData(cell : ReviewCell , feedback : Feedback){
        cell.nameLbl.text = feedback.patient?.first_name ?? ""
        cell.dateLbl.text = dateConvertor(feedback.created_at ?? "", _input: .date_time, _output: .DM)
        cell.deasesLbl.text = feedback.visited_for ?? ""
        cell.reviewLbl.text = feedback.comments ?? ""

        if (feedback.experiences ?? "") == "LIKE"{
            cell.thumpsupImg.setImage("like")
        }else{
            cell.thumpsupImg.setImage("dislike")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.photosCV{
            return CGSize(width: 100, height: 100)
        }else if collectionView == self.reviewsCV{
            return CGSize(width:  (UIScreen.main.bounds.width / 2) + 10, height: 120)
        }

        return CGSize(width: 200, height: 100)
    }
    
    func setupCollectionViewCell(){
        self.photosCV.registerCell(withId: XIB.Names.PhotosCell)
        self.reviewsCV.registerCell(withId: XIB.Names.ReviewCell)
        self.photosCV.reloadData()
         self.reviewsCV.reloadData()
    }
}


//Api calls
extension DoctorDetailsController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.CommonModel:
                let data = dataDict as? CommonModel
                if (data?.message ?? "") == "Favourite Doctor Added"{
                    self.btnFavourite.setImage(UIImage(named: "love_red"), for: .normal)
                    self.docProfile.hospital?[0].is_favourite = "true"
                }else{
                    self.btnFavourite.setImage(UIImage(named: "love"), for: .normal)
                    self.docProfile.hospital?[0].is_favourite = "false"
                }
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func addRemoveFav(patient_id : String , doctor_id : String){
        self.presenter?.HITAPI(api: Base.fav.rawValue, params: ["patient_id" : patient_id , "doctor_id" : doctor_id], methodType: .POST, modelClass: CommonModel.self, token: true)
    }
    
}
