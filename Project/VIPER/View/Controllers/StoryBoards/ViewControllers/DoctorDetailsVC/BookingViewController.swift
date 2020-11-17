//
//  BookingViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 17/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import CLWeeklyCalendarView
import ObjectMapper

class BookingViewController: UIViewController {
    
    
    @IBOutlet weak var doctorImg : UIImageView!
    @IBOutlet weak var doctorNameLbl : UILabel!
    @IBOutlet weak var splstLbl : UILabel!
    @IBOutlet weak var addressLbl : UILabel!
    @IBOutlet weak var followupView : UIView!
    @IBOutlet weak var consultantView : UIView!
    @IBOutlet weak var followupImg : UIImageView!
    @IBOutlet weak var consultantImg : UIImageView!
    @IBOutlet weak var proceedBtn : UIButton!
    @IBOutlet weak var calendarView: CLWeeklyCalendarView!
    @IBOutlet weak var timeCollectionCV: UICollectionView!

    var isFollowUp = false
    var searchDoctor : Search_doctors = Search_doctors()
    var docProfile : Doctor_profile = Doctor_profile()
    var bookingreq : BookingReq = BookingReq()
    var isFromSearch : Bool = false
    var scheduleDate = Date()
    var scheduleDateString : String = String()
    var categoryId : Int = 0
    var timeArr = ["9:30","8:30","8:30","8:30","8:30","8:30","8:30","8:30"]
    var merdianArr = ["AM","PM","AM","PM","AM","PM","AM","PM"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.registerCell()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func initialLoad()  {
        self.setupNavigation()
        self.setupAction()
        self.populateData()
        self.setCalendarView()
    }
    
    func setupNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Booking"
        self.followupImg.image = UIImage(named: "RadioON")
        self.bookingreq.booking_for = "follow_up"
        self.followupImg.changeTintColor(color: .AppBlueColor)
        self.consultantImg.changeTintColor(color: .AppBlueColor)
        self.isFollowUp = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.doctorImg.makeRoundedCorner()
    }
    
    private func registerCell(){
       
        
        self.timeCollectionCV.register((UINib(nibName: "TimeCell", bundle: nil)), forCellWithReuseIdentifier: "TimeCell")
        
    
    }
    
    func setupAction(){
//
//        let selectedImg = UIImage(named: "RadioON")
//        let unSelectedImg = UIImage(named: "RadioOFF")
//
//
//        for (index,values) in [self.followupImg,self.consultantImg].enumerated() {
//
//            if values?.tag == 101 {
//
//                values?.image = values?.image == selectedImg ? unSelectedImg : selectedImg
//
//            }else{
//                values?.image = values?.image == selectedImg ? unSelectedImg : selectedImg
//
//            }
//
//        }
//
//        [self.followupImg,self.consultantImg].forEach { (imageView) in
//
//            imageView?.addTap {
//
//                imageView?.changeTintColor(color: .AppBlueColor)
//                self.isFollowUp = imageView?.tag == 101 ? !self.isFollowUp : self.isFollowUp
//                self.bookingreq.booking_for = imageView?.tag == 101 ?  "follow_up" : "consultation"
//
//
//
//            }
//        }
        
        self.followupView.addTap {
            self.followupImg.image = UIImage(named: "RadioON")
            self.consultantImg.image = UIImage(named: "RadioOFF")
            self.followupImg.changeTintColor(color: UIColor.AppBlueColor)
            self.consultantImg.changeTintColor(color: UIColor.AppBlueColor)
            self.bookingreq.booking_for = "follow_up"
            self.isFollowUp = true
        }

        self.consultantView.addTap {
            self.followupImg.image = UIImage(named: "RadioOFF")
            self.consultantImg.image = UIImage(named: "RadioON")
            self.followupImg.changeTintColor(color: UIColor.AppBlueColor)
            self.consultantImg.changeTintColor(color: UIColor.AppBlueColor)
            self.bookingreq.booking_for = "consultation"
             self.isFollowUp = false
        }
        
        self.proceedBtn.addTap {
//            if self.scheduleDate.interval(ofComponent: .day, fromDate: Date()) < 0{
//                 showToast(msg: "Please select today or upcoming date only")
//            }else{
                let view = TimePickerAlert.getView
                view.alertdelegate = self
                view.schduleDate = self.scheduleDate
                AlertBuilder().addView(fromVC: self , view).show()
//            }
        }
    }
    
    func setCalendarView() {
        self.calendarView.calendarAttributes = [
            CLCalendarBackgroundImageColor : UIColor(named: "LightBackgroundGrey") ?? .white,
            CLCalendarPastDayNumberTextColor : UIColor.AppBlueColor,
            CLCalendarFutureDayNumberTextColor : UIColor.AppBlueColor,
            CLCalendarCurrentDayNumberTextColor :  UIColor.AppBlueColor,
            CLCalendarCurrentDayNumberBackgroundColor : UIColor(named: "LightBackgroundGrey") ?? .white,
            CLCalendarFont:UIFont(name:FontCustom.meduim.rawValue, size: 14) ?? UIFont(),

            CLCalendarSelectedDayNumberTextColor : UIColor.white,
            CLCalendarSelectedDayNumberBackgroundColor : UIColor.appColor,
            CLCalendarSelectedCurrentDayNumberTextColor : UIColor.white,
            CLCalendarSelectedCurrentDayNumberBackgroundColor : UIColor.AppBlueColor,
            
            CLCalendarDayTitleTextColor :UIColor.AppBlueColor,
            CLCalendarWeekStartDay : 1]
//CLCalendarSelectedDatePrintColor : UIColor(named: "GreyTextcolor") ?? UIColor.darkGray
        self.calendarView.delegate = self
        
        
    }

    
    func populateData(){
//        if let detail : Hospital = self.docProfile.hospital?[0]{
        if !isFromSearch{
            let detail : Hospital = (self.docProfile.hospital?[0])!
                self.bookingreq.doctor_id = ( self.docProfile.id ?? 0 ).description
            self.doctorNameLbl.text = "\(detail.first_name ?? "") \(detail.last_name ?? "")"
//            self.doctorImg.pin_setImage(from: URL(string: imageURL+"\(detail.doctor_profile?.profile_pic)")
//            self.doctorImg.setImage(imageURL + "\(imageURL + "\(detail.doctor_profile?.profile_pic ?? "")")")
            self.doctorImg.setURLImage("\(detail.doctor_profile?.profile_pic ?? "")" )

             //   self.doctorImg.makeRoundedCorner()
            self.splstLbl.text = "\(self.docProfile.speciality?.name ?? "")" //"\(detail.doctor_profile?.speciality?.name ?? "")"
                self.addressLbl.text = "\(detail.clinic?.name ?? "") \(detail.clinic?.address ?? "")"
        }else{
            self.bookingreq.doctor_id = ( self.searchDoctor.id ?? 0 ).description
              self.doctorNameLbl.text = "\(self.searchDoctor.first_name ?? "") \(self.searchDoctor.last_name ?? "")"
              self.doctorImg.pin_setImage(from: URL(string: imageURL+"\(self.searchDoctor.doctor_profile?.profile_pic ?? "")")!)
              self.doctorImg.makeRoundedCorner()
              self.splstLbl.text = "\(self.searchDoctor.doctor_profile?.speciality?.name ?? "")"
              self.addressLbl.text = "\(self.searchDoctor.clinic?.name ?? "") \(self.searchDoctor.clinic?.address ?? "")"
        }
      
        
        
    }
    
}

extension BookingViewController : CLWeeklyCalendarViewDelegate{
    func dailyCalendarViewDidSelect(_ date: Date!) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        self.scheduleDate = date
        self.scheduleDateString = dateFormatterGet.string(from: date)
    }
    
}

extension BookingViewController : AlertDelegate{
    func selectedDate(date: String, month: String, year: String, dob: String, alertVC: UIViewController) {
            
    }
    
    func selectedTime(time: String, alertVC: UIViewController) {
        self.bookingreq.scheduled_at = "\(self.scheduleDateString) \(time)"
        self.bookingreq.service_id = "\(self.categoryId)"
        let vc = PatientDetailViewController.initVC(storyBoardName: .main, vc: PatientDetailViewController.self, viewConrollerID: Storyboard.Ids.PatientDetailViewController)
        vc.bookingreq = self.bookingreq
        vc.categoryId = self.categoryId
        vc.searchDoctor = self.searchDoctor
        vc.docProfile = self.docProfile
        vc.isfromSearch = self.isFromSearch
        vc.isFollowup = self.isFollowUp
        self.push(from: self, ToViewContorller: vc)
    }
    
}



extension BookingViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
        {
        
       
            return self.timeArr.count
        
        
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath) as! TimeCell
        cell.timeLbl.text = self.timeArr[indexPath.item]
        cell.meridianLbl.text = self.merdianArr[indexPath.item]

        return cell
        
    }
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

//        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        
        return CGSize(width: collectionView.frame.width/6 , height: 70)
        
       }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell  = collectionView.cellForItem(at: indexPath) as! TimeCell
        cell.timeLbl.textColor = .white
        cell.meridianLbl.textColor = .white
        cell.timeView.borderColor = .AppBlueColor
        cell.timeView.backgroundColor = .AppBlueColor

//        let vc = DoctorsListController.initVC(storyBoardName: .main, vc: DoctorsListController.self, viewConrollerID: "DoctorsListController")
//        vc.catagoryID = self.category[indexPath.row].id ?? 0
//        self.push(from: self, ToViewContorller: vc)
    }


    
}


extension UIImageView{
    
    func changeTintColor(color:UIColor?)  {
        
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color

    }
}
