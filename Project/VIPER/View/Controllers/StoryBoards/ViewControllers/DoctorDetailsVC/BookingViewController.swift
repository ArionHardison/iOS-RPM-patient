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

    var isFollowUp : Bool = false
    var searchDoctor : Search_doctors = Search_doctors()
    var docProfile : Doctor_profile = Doctor_profile()
    var bookingreq : BookingReq = BookingReq()
    var isFromSearch : Bool = false
    var scheduleDate = Date()
    var scheduleDateString : String = String()
    var categoryId : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        self.isFollowUp = true
    }
    
    func setupAction(){
        self.followupView.addTap {
            self.followupImg.image = UIImage(named: "RadioON")
            self.consultantImg.image = UIImage(named: "RadioOFF")
            self.bookingreq.booking_for = "follow_up"
            self.isFollowUp = true
        }
        
        self.consultantView.addTap {
            self.followupImg.image = UIImage(named: "RadioOFF")
            self.consultantImg.image = UIImage(named: "RadioON")
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
        self.calendarView.calendarAttributes = [CLCalendarBackgroundImageColor : UIColor.clear,
                                                
            CLCalendarPastDayNumberTextColor : UIColor.darkGray,
            CLCalendarFutureDayNumberTextColor : UIColor.darkGray,
            
            CLCalendarCurrentDayNumberTextColor : UIColor.darkGray,
            CLCalendarCurrentDayNumberBackgroundColor : UIColor.clear,
            
            CLCalendarSelectedDayNumberTextColor : UIColor.white,
            CLCalendarSelectedDayNumberBackgroundColor : UIColor.appColor,
            CLCalendarSelectedCurrentDayNumberTextColor : UIColor.white,
            CLCalendarSelectedCurrentDayNumberBackgroundColor : UIColor.appColor,
            
            CLCalendarDayTitleTextColor : UIColor.darkGray,
            CLCalendarSelectedDatePrintColor : UIColor.darkGray,
            CLCalendarWeekStartDay : 1]
        self.calendarView.delegate = self
        
        
    }

    
    func populateData(){
//        if let detail : Hospital = self.docProfile.hospital?[0]{
        if !isFromSearch{
            let detail : Hospital = (self.docProfile.hospital?[0])!
                self.bookingreq.doctor_id = ( self.docProfile.id ?? 0 ).description
            self.doctorNameLbl.text = "\(detail.first_name ?? "") \(detail.last_name ?? "")"
//            self.doctorImg.pin_setImage(from: URL(string: imageURL+"\(detail.doctor_profile?.profile_pic)")
            self.doctorImg.setImage(imageURL + "\(imageURL + "\(detail.doctor_profile?.profile_pic ?? "")")")
                self.doctorImg.makeRoundedCorner()
                self.splstLbl.text = "\(detail.doctor_profile?.speciality?.name ?? "")"
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


