//
//  DateOfBirthViewController.swift
//  Project
//
//  Created by Chan Basha on 04/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper
import IQKeyboardManagerSwift

protocol AlertDelegate {
    func selectedDate(date : String,month : String,year : String,dob : String ,alertVC : UIViewController)
    func selectedTime(time : String,alertVC : UIViewController)
}

class DateOfBirthViewController: UIViewController {
    
    @IBOutlet weak var buttonBack: UIButton!
    
    
    @IBOutlet weak var labelCount: UILabel!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var txtdate: UITextField!
    
    @IBOutlet weak var txtMonth: UITextField!
    
    @IBOutlet weak var txtYear: UITextField!
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var datepickerBtn: UIButton!
    
    
    var signupReq: SignupReq?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAction()
        IQKeyboardManager.shared.enable = true
        buttonBack.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        btnContinue.addTarget(self, action: #selector(continueAction(sender:)), for: .touchUpInside)
    }
    
    
    func setupAction(){
        self.datepickerBtn.addTap {
            let view = DatePickerAlert.getView
            view.alertdelegate = self
            view.datepicker.maximumDate = Date()
            AlertBuilder().addView(fromVC: self , view).show()
        }
    }
    
    @IBAction func continueAction(sender:UIButton){
        
        if !(self.signupReq?.dob ?? "").isEmpty{
            self.signupApi()
        }else{
            showToast(msg: "Select your Date of Birth")
        }
    }
    
    @IBAction func backAction(sender:UIButton){
        backButtonClick()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


//Api calls
extension DateOfBirthViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.SignupResponseModel:
                var data = dataDict as? SignupResponseModel
                if !(data?.access_token?.original?.token ?? "").isEmpty{
                    UserDefaultConfig.Token = data?.access_token?.original?.token ?? ""
                    self.navigationController?.present(Common.setDrawerController(), animated: true, completion: nil)
                }else{
                    showToast(msg: "The given data was invalid.")
                }
                break
            default: break
        }
    }
    
    func showError(error: CustomError) {
        showToast(msg: error.localizedDescription)
        
    }
    
    func signupApi(){
        self.presenter?.HITAPI(api: Base.signup.rawValue, params: convertToDictionary(model: self.signupReq), methodType: .POST, modelClass: SignupResponseModel.self, token: false)
    }
}



extension DateOfBirthViewController : AlertDelegate{
    func selectedTime(time: String, alertVC: UIViewController) {
        
    }
    
    func selectedDate(date: String, month: String, year: String, dob: String, alertVC: UIViewController) {
        self.txtdate.text = date
        self.txtMonth.text = month
        self.txtYear.text = year
        self.signupReq?.dob = dob
    }
}
