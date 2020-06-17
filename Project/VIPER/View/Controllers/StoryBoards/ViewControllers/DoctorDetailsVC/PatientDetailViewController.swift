//
//  PatientDetailViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 17/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class PatientDetailViewController: UIViewController {

    
    @IBOutlet weak var doctorImg : UIImageView!
    @IBOutlet weak var doctorNameLbl : UILabel!
    @IBOutlet weak var clinicDetailLbl : UILabel!
    
    @IBOutlet weak var patientDetailLbl : UILabel!
    @IBOutlet weak var bookingforTitleLbl : UILabel!
    @IBOutlet weak var dateandtimeTitleLbl : UILabel!
    @IBOutlet weak var doctorInfoTitleLbl : UILabel!
    @IBOutlet weak var bookingforLbl : UILabel!
    @IBOutlet weak var dateandtimeLbl : UILabel!
    @IBOutlet weak var nameTxt : HoshiTextField!
    @IBOutlet weak var emailTxt : HoshiTextField!
    @IBOutlet weak var phonenumTxt : HoshiTextField!
    
    @IBOutlet weak var confirmBtn : UIButton!

    
    var docProfile : Doctor_profile = Doctor_profile()
    var bookingreq : BookingReq = BookingReq()
    
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
        self.setupFont()
    }
    
    func setupNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Enter patient detail"
    }
    
    func setupFont(){
        [self.doctorNameLbl , self.clinicDetailLbl , self.patientDetailLbl ,self.bookingforTitleLbl,self.dateandtimeTitleLbl ,self.doctorInfoTitleLbl,self.bookingforLbl,self.dateandtimeLbl].forEach { (label) in
            
            Common.setFont(to: label)
        }
    }

     func setupAction(){
        self.confirmBtn.addTap {
            if self.validation(){
                self.bookingreq.consult_time = "5"
                self.bookingreq.appointment_type = "ONLINE"
                self.bookingreq.description = "Patient Testing Purpose"
                self.bookingApointment(booking : self.bookingreq)
            }
        }
    }
    
    func populateData(){
        self.dateandtimeLbl.text = dateConvertor(self.bookingreq.scheduled_at, _input: .date_time, _output: .DMY_Time)
        self.bookingforLbl.text = self.bookingreq.booking_for.capitalized
        if let detail : Hospital = self.docProfile.hospital?[0]{
            self.bookingreq.doctor_id = ( self.docProfile.id ?? 0 ).description
            self.doctorNameLbl.text = "\(detail.first_name ?? "") \(detail.last_name ?? "")"
            self.doctorImg.pin_setImage(from: URL(string: imageURL+"\(self.docProfile.profile_pic ?? "")")!)
            self.doctorImg.makeRoundedCorner()
            self.clinicDetailLbl.text = "\(detail.clinic?.name ?? "") \(detail.clinic?.address ?? "")"
        }
    }
    
    func validation() -> Bool{
        if self.nameTxt.getText.isEmpty{
            showToast(msg: "Enter Patient Name")
            return false
        }else if self.emailTxt.getText.isEmpty || !self.emailTxt.getText.isValidEmail(){
            showToast(msg: "Enter Valid EmailID")
            return false
        }else if self.phonenumTxt.getText.isEmpty || !self.phonenumTxt.getText.isPhoneNumber{
            showToast(msg: "Enter Valid Mobile Number")
            return false
        }else{
            return true
        }
    }
}
//Api calls
extension PatientDetailViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.BookingModel:
                let data = dataDict as? BookingModel
               
                if data?.status ?? false{
                    showToast(msg: "Appointment booking successfully")
                    self.navigationController?.popToRootViewController(animated: true)
                }
                
                break
            
            default:
                break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func bookingApointment(booking : BookingReq){
        self.presenter?.HITAPI(api: Base.booking.rawValue, params: convertToDictionary(model: booking), methodType: .POST, modelClass: BookingModel.self, token: true)
    }
    
}
