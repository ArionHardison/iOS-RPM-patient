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
    @IBOutlet weak var verifiedImg: UIImageView!
    @IBOutlet weak var labelVerified: UILabel!
    @IBOutlet weak var labelConsultationfee: UILabel!

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
    @IBOutlet weak var specilizationVHeight: NSLayoutConstraint!

    @IBOutlet weak var serviceTVHeight: NSLayoutConstraint!
    @IBOutlet weak var serviceVHeight: NSLayoutConstraint!
    @IBOutlet weak var timingHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var innerScrolllView: UIView!

//
    //inital static Data
    
    var searchDoctor = Search_doctors()
    var docProfile = Doctor_profile()
    var favouriteDoctor : Favourite_Doctors?
    var isfromFavourite : Bool = false
    var isFromSearchDoctor:Bool = true
    var speciality : [String] = [String]()
    var categoryID : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //View Setup
        self.initialLoads()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.populateData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("Hello")
    }
    
    
    func populateData(){
        
        if !isFromSearchDoctor {
            if isfromFavourite {
               let detail : Hospital = (self.favouriteDoctor?.hospital) ?? Hospital()
               self.labelDoctorName.text = "\(detail.first_name ?? "") \(detail.last_name ?? "")"
               self.imgDoctor.setURLImage(detail.doctor_profile?.profile_pic ?? "")
                self.imgDoctor.makeRoundedCorner()
                self.labelConsultationfee.text = "Consulation Fees" +  "$\(detail.doctor_profile?.fees ?? 0)"
               self.labelQualification.text = "Consulation Fees" + "$ \(detail.doctor_profile?.speciality?.name ?? "")"
               self.labelPercentage.text = "\(detail.feedback_percentage ?? "") %"
                self.speciality.append(self.favouriteDoctor?.hospital?.doctor_profile?.speciality?.name ?? "")
            //   self.imgLocationPreview.pin_setImage(from: URL(string: detail.clinic?.static_map ?? "")!)
               self.labelClinicName.text = detail.clinic?.name ?? "".capitalized
               self.labelLocationValue.text = detail.clinic?.address ?? "".capitalized
               if (detail.is_favourite ?? "") == "false"{
                   self.btnFavourite.setImage(UIImage(named: "love"), for: .normal)
               }else{
                   self.btnFavourite.setImage(UIImage(named: "love_red"), for: .normal)
               }
    }else{        let detail : Hospital = (self.docProfile.hospital?.first) ?? Hospital()
            self.labelDoctorName.text = "\(detail.first_name ?? "") \(detail.last_name ?? "")"
            self.imgDoctor.setURLImage(detail.doctor_profile?.profile_pic ?? "")
             self.imgDoctor.makeRoundedCorner()
            self.labelConsultationfee.text = "Consulation Fees  " +  "$ \(self.docProfile.fees ?? 0)"
            self.labelQualification.text = "\(self.docProfile.speciality?.name ?? "")"
            self.labelPercentage.text = "\(detail.feedback_percentage ?? "") %"
            self.speciality.append(self.docProfile.speciality?.name ?? "")
         //   self.imgLocationPreview.pin_setImage(from: URL(string: detail.clinic?.static_map ?? "")!)
            self.labelClinicName.text = detail.clinic?.name ?? "".capitalized
            self.labelLocationValue.text = detail.clinic?.address ?? "".capitalized
            if (detail.is_favourite ?? "") == "false"{
                self.btnFavourite.setImage(UIImage(named: "love"), for: .normal)
            }else{
                self.btnFavourite.setImage(UIImage(named: "love_red"), for: .normal)
            }
            }
        }else{
            
            let car = self.searchDoctor.timing?.count == 0 ? 0 : 70
            let cr = 30 * (self.searchDoctor.timing?.count)! + 1
            let cr2 = 30 * (self.searchDoctor.timing?.count)! + car
            
            self.serviceTVHeight.constant = CGFloat(cr)
            self.serviceVHeight.constant = CGFloat(cr2)

            let specialityFloat1 = 40 * 1
            let specialityFloat2 = (40 * 1) + 70

            self.specilizationTVHeight.constant = CGFloat(specialityFloat1)
            self.specilizationVHeight.constant = CGFloat(specialityFloat2)
//            self.categoryID = self.searchDoctor.doctor_profile.
              
                self.labelDoctorName.text = "\(self.searchDoctor.first_name ?? "")" + " " + "\(self.searchDoctor.last_name ?? "")"
                self.imgDoctor.setURLImage(self.searchDoctor.doctor_profile?.profile_pic ?? "")
                     self.imgDoctor.makeRoundedCorner()
                
            self.labelConsultationfee.text = "Consulation Fees  " +  "$ \(self.docProfile.fees ?? 0)"
            self.labelQualification.text = "\(self.docProfile.speciality?.name ?? "")"
                self.labelQualification.text = "\(self.searchDoctor.doctor_profile?.certification ?? "")".capitalized
        //        self.labelPercentage.text = "\(self.docProfile.feedback?.first.) %"
                self.speciality.append((self.searchDoctor.doctor_profile?.speciality?.name ?? "").capitalized)
                 //   self.imgLocationPreview.pin_setImage(from: URL(string: detail.clinic?.static_map ?? "")!)
            self.labelClinicName.text = self.searchDoctor.clinic?.name ?? "".capitalized
                self.labelLocationValue.text = self.searchDoctor.clinic?.address ?? "".capitalized
                if (self.searchDoctor.is_favourite ?? "") == "false"{
                        self.btnFavourite.setImage(UIImage(named: "love"), for: .normal)
                    }else{
                        self.btnFavourite.setImage(UIImage(named: "love_red"), for: .normal)
                    }
                }
            
            self.servicesTV.reloadInMainThread()
            self.specilizationTV.reloadInMainThread()
            self.timingTableView.reloadInMainThread()
            
        
    }
    
    
    func setupAction(){
        self.btnFavourite.addTap {
            if !self.isFromSearchDoctor{
                if self.isfromFavourite{
                    self.addRemoveFav(patient_id: UserDefaultConfig.PatientID, doctor_id: (self.favouriteDoctor?.id ?? 0).description)
                }else{
            self.addRemoveFav(patient_id: UserDefaultConfig.PatientID, doctor_id:(self.docProfile.id ?? 0).description)
            }
            }else{
                self.addRemoveFav(patient_id: UserDefaultConfig.PatientID, doctor_id:(self.searchDoctor.id ?? 0).description)
            }
            }
        
        self.bookBtn.addTap {
            let vc = BookingViewController.initVC(storyBoardName: .main, vc: BookingViewController.self, viewConrollerID: Storyboard.Ids.BookingViewController)
                     vc.docProfile = self.docProfile
                     vc.searchDoctor = self.searchDoctor
                     vc.isFromSearch = self.isFromSearchDoctor
                     vc.isfromFavourite = self.isfromFavourite
                     vc.favouriteDoctor = self.favouriteDoctor
                     vc.categoryId = self.categoryID
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
//        self.navigationItem.rightBarButtonItems = [shareButton,infoButton]
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
            if isFromSearchDoctor{
                return self.searchDoctor.doctor_service?.count ?? 0
            }else{
                if isfromFavourite{
                    return self.favouriteDoctor?.hospital?.doctor_service?.count ?? 0
                }else{
                return self.docProfile.hospital?.first?.doctor_service?.count ?? 0
                }
            }
            
            
        }else if tableView == self.specilizationTV{
                return self.speciality.count
        }else if tableView == self.timingTableView{
            if isFromSearchDoctor{
                return self.searchDoctor.timing?.count ?? 0
            }else{
                if isfromFavourite{
                    return (self.favouriteDoctor?.hospital?.timing?.count ?? 0)
                }else{
                return (self.docProfile.hospital?.first?.timing?.count ?? 0)
                }
            }
        }
        else{
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFromSearchDoctor{
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ServiceSpecializationCell) as! ServiceSpecializationCell
        
        if tableView == self.servicesTV{
            cell.serviceLbl.text = self.searchDoctor.doctor_service?[indexPath.row].service?.name ?? ""
        }else if tableView == self.specilizationTV{
            cell.serviceLbl.text = self.speciality[indexPath.row]
        }else if tableView == self.timingTableView{
            if let timing : Timing = self.searchDoctor.timing?[indexPath.row]{
                cell.dotImg.isHidden = false
                self.setSeatchCountLbl(label: cell.serviceLbl, day: "\(timing.day ?? "") - " , timing: "\(timing.start_time ?? "") : \(timing.end_time ?? "")")
            }
        }
        
        self.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        return cell
        } else{
            if isfromFavourite{
                    let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ServiceSpecializationCell) as! ServiceSpecializationCell
                    
                    if tableView == self.servicesTV{
                        cell.serviceLbl.text = self.favouriteDoctor?.hospital?.doctor_service?[indexPath.row].service?.name ?? ""
//                        cell.lblLeadConstraints.constant = 10

                    }else if tableView == self.specilizationTV{
                        cell.serviceLbl.text = self.speciality[indexPath.row]
                    }else if tableView == self.timingTableView{
                        if let timing : Timing = self.favouriteDoctor?.hospital?.timing?[indexPath.row]{
//                            cell.dotImg.isHidden = true
//                            cell.lblLeadConstraints.constant = -50
                            self.setSeatchCountLbl(label: cell.serviceLbl, day: "\(timing.day ?? "") -" , timing: "\(timing.start_time ?? "") : \(timing.end_time ?? "")")
                        }
                    }
                    
                    self.viewDidLayoutSubviews()
                    self.view.layoutIfNeeded()
                    return cell
            }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ServiceSpecializationCell) as! ServiceSpecializationCell
        
        if tableView == self.servicesTV{
            cell.serviceLbl.text = self.docProfile.hospital?.first?.doctor_service?[indexPath.row].service?.name ?? ""
//            cell.lblLeadConstraints.constant = 10

        }else if tableView == self.specilizationTV{
            cell.serviceLbl.text = self.speciality[indexPath.row]
        }else if tableView == self.timingTableView{
            if let timing : Timing = self.docProfile.hospital?.first?.timing?[indexPath.row]{
                cell.dotImg.isHidden = true
//                cell.lblLeadConstraints.constant = -10
                self.setSeatchCountLbl(label: cell.serviceLbl, day: "\(timing.day ?? "") -" , timing: "\(timing.start_time ?? "") : \(timing.end_time ?? "")")
            }
        }
        
        self.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        return cell
        }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
//
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = createViewAllButtion()
        footerView.addTap {
            
            self.push(id: Storyboard.Ids.ServiceListViewController, animation: true)
            
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if isFromSearchDoctor {
        if tableView == self.servicesTV{
            if (self.searchDoctor.doctor_service?.count ?? 0) > 4{
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
        }else if tableView == self.timingTableView{
                
                return UITableViewAutomaticDimension
              
            }
          
       
         
    }else{
            if isfromFavourite{
                if tableView == self.servicesTV{
                    if (self.favouriteDoctor?.hospital?.doctor_service?.count ?? 0) > 4{
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
                else if tableView == self.timingTableView{
                        
                        return UITableViewAutomaticDimension
                      
                    }
                 
            }else {
        if tableView == self.servicesTV{
            if (self.docProfile.hospital?.first?.doctor_service?.count ?? 0) > 4{
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
        else if tableView == self.timingTableView{
                
                return UITableViewAutomaticDimension
              
            }
         
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
        let viewLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))

        
        Common.setFontWithType(to: viewLabel, size: 12, type: .regular)
        //Common.setFont(to: viewLabel,isTitle : true)
        viewLabel.text = "View all >"
        viewLabel.textAlignment = .center
        viewLabel.textColor = UIColor(named: "AppBlueColor")
        customView.addSubview(viewLabel)
        return customView
    }
    
    
    func setSeatchCountLbl(label : UILabel,day : String , timing : String){
        let attrs1 = [NSAttributedString.Key.font : UIFont.init(name: FontCustom.regular.rawValue, size: 14), NSAttributedString.Key.foregroundColor : UIColor.red.withAlphaComponent(0.8)]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.init(name: FontCustom.regular.rawValue, size: 14), NSAttributedString.Key.foregroundColor : UIColor(named: "TextBlackColor")]
        
        let attributedString1 = NSMutableAttributedString(string: "\(day) ", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: timing, attributes:attrs2)
        
        attributedString1.append(attributedString2)
        label.attributedText = attributedString1
    }
}


extension DoctorDetailsController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFromSearchDoctor{
        if collectionView == self.photosCV{
            return  10
        }else if collectionView == self.reviewsCV{
            return  self.searchDoctor.feedback?.count ?? 0
        }
        return  0
        }else{
        if collectionView == self.photosCV{
            return  10
        }else if collectionView == self.reviewsCV{
            return  self.docProfile.hospital?.first?.feedback?.count ?? 0
        }
        return  0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.photosCV{
            let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.Names.PhotosCell, for: indexPath) as! PhotosCell
            return photoCell
        }else if collectionView == self.reviewsCV{
            let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.Names.ReviewCell, for: indexPath) as! ReviewCell
            if isFromSearchDoctor{
            self.populateFeedBackData(cell: reviewCell, feedback: self.searchDoctor.feedback?[indexPath.row] ?? Feedback())
            } else{
                self.populateFeedBackData(cell: reviewCell, feedback: self.docProfile.hospital?.first?.feedback?[indexPath.row] ?? Feedback())
            }
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
                    if isFromSearchDoctor{
                    self.searchDoctor.is_favourite = "true"
                    }else{
                        self.docProfile.hospital?[0].is_favourite = "true"
                    }
                }else{
                    self.btnFavourite.setImage(UIImage(named: "love"), for: .normal)
                                        if isFromSearchDoctor{
                    self.searchDoctor.is_favourite = "false"
                    }else{
                        self.docProfile.hospital?[0].is_favourite = "false"
                    }
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
extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
