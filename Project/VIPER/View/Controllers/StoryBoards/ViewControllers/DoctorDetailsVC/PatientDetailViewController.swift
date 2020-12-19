//
//  PatientDetailViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 17/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper
import IQKeyboardManagerSwift

class PatientDetailViewController: UIViewController {

    
    @IBOutlet weak var doctorImg : UIImageView!
    @IBOutlet weak var doctorNameLbl : UILabel!
    @IBOutlet weak var clinicDetailLbl : UILabel!
    @IBOutlet weak var scrollInnerView : UIView!
    @IBOutlet weak var scrollView : UIScrollView!

    @IBOutlet weak var patientDetailLbl : UILabel!
    @IBOutlet weak var bookingforTitleLbl : UILabel!
    @IBOutlet weak var dateandtimeTitleLbl : UILabel!
    @IBOutlet weak var doctorInfoTitleLbl : UILabel!
    @IBOutlet weak var bookingforLbl : UILabel!
    @IBOutlet weak var dateandtimeLbl : UILabel!
    @IBOutlet weak var nameTxt : HoshiTextField!
    @IBOutlet weak var emailTxt : HoshiTextField!
    @IBOutlet weak var phonenumTxt : HoshiTextField!
    @IBOutlet weak var paymentTypeLabel: UILabel!
    @IBOutlet weak var changePaymentButton: UIButton!
    
    @IBOutlet weak var confirmBtn : UIButton!

    var categoryId : Int = 0
    var docProfile : Doctor_profile = Doctor_profile()
    var searchDoctor : Search_doctors = Search_doctors()
    var isfromSearch : Bool = false
    var bookingreq : BookingReq = BookingReq()
    var isFollowup : Bool = false
    var invoiceView : InvoiceView!
    var selectedPaymentType : String = "wallet"
    var cardId : String = ""
    
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
//        self.setupFont()
         IQKeyboardManager.shared.enable = false
        self.changePaymentButton.addTarget(self, action: #selector(changePaymentAction(_sender:)), for: .touchUpInside)
//        self.scrollView.addSubview(self.scrollInnerView)
//        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollInnerView.frame.height)
    }
    
    func setupNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Enter patient detail"
    }
    
    @IBAction private func changePaymentAction(_sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.PaymentSelectViewController) as! PaymentSelectViewController
        vc.modalPresentationStyle = .automatic
        vc.onSelectPaymentType = { (paymentType,card_id,lastfour) in
            self.selectedPaymentType = paymentType
            self.cardId = card_id
            if self.selectedPaymentType == "stripe"{
                self.paymentTypeLabel.text = "XXXX-XXXX-XXXX-\(lastfour)"
            }else{
            self.paymentTypeLabel.text = paymentType
            }
            vc.dismiss(animated: true, completion: nil)
            
        }
        let nav = UINavigationController(rootViewController: vc)
        self.navigationController?.present(nav, animated: true, completion: nil)
        
    }

     func setupAction(){
        self.confirmBtn.addTap {
            if self.validation(){
                var params = [String:Any]()
                if !self.isfromSearch{
                    params.updateValue("5", forKey: "consult_time") //self.bookingreq.consult_time = "5"
                    params.updateValue("OFFLINE", forKey: "appointment_type")   // self.bookingreq.appointment_type = "ONLINE"
                    params.updateValue("Appointment", forKey: "description")//     self.bookingreq.description = "Patient Testing Purpose"
                    params.updateValue("\(self.docProfile.doctor_id ?? 0)", forKey: "doctor_id") //self.bookingreq.doctor_id = "\(self.docProfile.id ?? 0)"
                    params.updateValue(self.isFollowup ? "follow_up" : "consultation", forKey: "booking_for") //self.bookingreq.booking_for =  self.isFollowup ? "follow_up" : "consultation"
                    params.updateValue(UserDefaultConfig.PatientID, forKey: "selectedPatient") // self.bookingreq.selectedPatient = UserDefaultConfig.PatientID
                    params.updateValue("\(self.categoryId)", forKey: "service_id") //self.bookingreq.service_id = "\(self.categoryId)"
                    params.updateValue(self.bookingreq.scheduled_at, forKey: "scheduled_at") //self.bookingreq.scheduled_at = self.bookingreq.scheduled_at
                    params.updateValue(self.selectedPaymentType, forKey: "payment_mode")
                    if self.selectedPaymentType == "stripe"{
                        params.updateValue(self.cardId, forKey: "card_id")
                    }
               
                 
                
                }else{
                    params.updateValue("15", forKey: "consult_time") //self.bookingreq.consult_time = "5"
                    params.updateValue("OFFLINE", forKey: "appointment_type")   // self.bookingreq.appointment_type = "ONLINE"
                    params.updateValue("Appoitment", forKey: "description")//     self.bookingreq.description = "Patient Testing Purpose"
                    params.updateValue(self.searchDoctor.doctor_profile?.doctor_id ?? 0, forKey: "doctor_id") //self.bookingreq.doctor_id = "\(self.docProfile.id ?? 0)"
                    params.updateValue(self.isFollowup ? "follow_up" : "consultation", forKey: "booking_for") //self.bookingreq.booking_for =  self.isFollowup ? "follow_up" : "consultation"
                    params.updateValue(UserDefaultConfig.PatientID, forKey: "selectedPatient") // self.bookingreq.selectedPatient = UserDefaultConfig.PatientID
                    params.updateValue(self.searchDoctor.doctor_service?.first?.service_id ?? 0, forKey: "service_id") //self.bookingreq.service_id = "\(self.categoryId)"
                    params.updateValue(self.bookingreq.scheduled_at, forKey: "scheduled_at")
                    //self.bookingreq.scheduled_at = self.bookingreq.scheduled_at
                    params.updateValue(self.selectedPaymentType, forKey: "payment_mode")
                    if self.selectedPaymentType == "stripe"{
                        params.updateValue(self.cardId, forKey: "card_id")
                    }
                    }

                self.bookingApointment(booking : params)

            }
        }
    }
    
    func populateData(){
        if isfromSearch {
        self.dateandtimeLbl.text = dateConvertor(self.bookingreq.scheduled_at, _input: .date_time, _output: .DMY_Time)
        self.bookingforLbl.text = self.bookingreq.booking_for.capitalized
//        if let detail : Hospital = self.docProfile.hospital?[0]{
            self.bookingreq.doctor_id = ( self.searchDoctor.id ?? 0 ).description
        self.doctorNameLbl.text = "\(self.searchDoctor.first_name ?? "")  \(self.searchDoctor.last_name ?? "")"
        self.doctorImg.pin_setImage(from: URL(string: imageURL+"\(self.searchDoctor.doctor_profile?.profile_pic ?? "")")!)
       //     self.doctorImg.makeRoundedCorner()
        self.clinicDetailLbl.text = "\(self.searchDoctor.clinic?.name ?? "") \(self.searchDoctor.clinic?.address ?? "")"
//        }
        } else {
                self.dateandtimeLbl.text = dateConvertor(self.bookingreq.scheduled_at, _input: .date_time, _output: .DMY_Time)
                self.bookingforLbl.text = self.bookingreq.booking_for.capitalized
        //        if let detail : Hospital = self.docProfile.hospital?[0]{
                    self.bookingreq.doctor_id = ( self.docProfile.id ?? 0 ).description
            self.doctorNameLbl.text = "\(self.docProfile.hospital?.first?.first_name ?? "")  \(self.docProfile.hospital?.first?.last_name ?? "")"
            self.doctorImg.pin_setImage(from: URL(string: imageURL+"\(self.docProfile.profile_pic ?? "")")!)
//                    self.doctorImg.makeRoundedCorner()
            self.clinicDetailLbl.text = "\(self.docProfile.hospital?.first?.clinic?.name ?? "") \(self.docProfile.hospital?.first?.clinic?.address ?? "")"
        //        }
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
               
                if Bool(data?.success ?? "false") ?? false{
                    showToast(msg: "Appointment booking successfully")
//
                    if self.invoiceView == nil, let invoice = Bundle.main.loadNibNamed(XIB.Names.InvoiceView, owner: self, options: [:])?.first as? InvoiceView {
                        invoice.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
                        self.invoiceView = invoice
                        self.invoiceView.populateData(invoice: data?.appointment?.invoice)
                        self.invoiceView.onClickDone = {
                            self.invoiceView.removeFromSuperview()
                            self.invoiceView = nil
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                        self.view.addSubview(self.invoiceView!)
                    }
                }
                
                break
            
            default:
                break
            
        }
    }
    
    func showError(error: CustomError) {
        showToast(msg: error.localizedDescription)
    }
    
    func bookingApointment(booking : [String:Any]){
        self.presenter?.HITAPI(api: Base.booking.rawValue, params: booking, methodType: .POST, modelClass: BookingModel.self, token: true)
    }
    
}


extension PatientDetailViewController : UITextFieldDelegate{
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        IQKeyboardManager.shared.enable = true

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       // Try to find next responder
       if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
          nextField.becomeFirstResponder()
       } else {
          // Not found, so remove keyboard.
          textField.resignFirstResponder()
       }
       // Do not add a line break
       return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}
