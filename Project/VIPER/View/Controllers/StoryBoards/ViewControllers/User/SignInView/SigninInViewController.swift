//
//  SigninInViewController.swift
//  Project
//
//  Created by Chan Basha on 04/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import CountryPickerView
import ObjectMapper
import IQKeyboardManagerSwift

class SigninInViewController: UIViewController {

    
    @IBOutlet weak var labelMobileNumber: UILabel!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var buttonContinue: UIButton!
    @IBOutlet weak var buttonTrouble: UIButton!
    @IBOutlet weak var labelLoginUsing: UILabel!
    @IBOutlet weak var labelFB: UILabel!
    @IBOutlet weak var labelGoogle: UILabel!
    @IBOutlet weak var labelTermsAndConditions: UILabel!
    @IBOutlet weak var countryCode : CountryPickerView!
   
    
    private var mobileVerifyData: MobileVerifyModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoads()
        IQKeyboardManager.shared.enable = true
       // txtMobileNumber.
    }

//    @IBAction func continueAction(sender:UIButton){
//        self.push(id: Storyboard.Ids.NameAndEmailViewController, animation: true)
//    }
    
    @IBAction func backAction(sender:UIButton){
           backButtonClick()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func initialLoads(){
        self.setupAction()
        self.setupTextDelegate()
        self.setupCountryPicker()
    }
    
    func setupAction(){
        self.buttonContinue.addTap {
            self.view.endEditing(true)
            if self.txtMobileNumber.getText.isEmpty || self.txtMobileNumber.getText.count < mobileNumDigit{
                showToast(msg: "Enter Valid MobileNumber")
            }else{
                var countrycode : String = self.countryCode.countryDetailsLabel.getText
                if countrycode.contains("+"){
                    countrycode = countrycode.replacingOccurrences(of: "+", with: "")
                }
                self.verifyNumber(mobileNum: "\(countrycode)\(self.txtMobileNumber.getText)")
             }
        }
    }

}


extension SigninInViewController :  CountryPickerViewDataSource {
  
    
    func setupCountryPicker(){
        countryCode.dataSource = self
        countryCode.showCountryCodeInView = false
        countryCode.showPhoneCodeInView = true
        countryCode.textColor = UIColor.black
        
        self.countryCode.setCountryByPhoneCode(country_code)
    }
   
}


extension SigninInViewController : UITextFieldDelegate{
    func setupTextDelegate(){
        self.txtMobileNumber.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        if (self.txtMobileNumber.text?.count)! > mobileNumDigit {
            self.txtMobileNumber.text = String(self.txtMobileNumber.getText.prefix(mobileNumDigit))
            self.view.endEditing(true)
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (self.txtMobileNumber.text?.count)! > mobileNumDigit {
            self.txtMobileNumber.text = String(self.txtMobileNumber.getText.prefix(mobileNumDigit))
             self.view.endEditing(true)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if (self.txtMobileNumber.text?.count)! > mobileNumDigit {
            self.txtMobileNumber.text = String(self.txtMobileNumber.getText.prefix(mobileNumDigit))
             self.view.endEditing(true)
        }
    }
    
}

//Api calls
extension SigninInViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.MobileVerifyModel:
                self.mobileVerifyData = dataDict as? MobileVerifyModel
                var countrycode : String = self.countryCode.countryDetailsLabel.getText
                if countrycode.contains("+"){
                    countrycode = countrycode.replacingOccurrences(of: "+", with: "")
                }
                self.mobileVerifyData?.mobileNum = "\(countrycode)\(self.txtMobileNumber.getText)"
                showToast(msg: self.mobileVerifyData?.message ?? "")
                
                let vc = VerifyNumVC.initVC(storyBoardName: .user, vc: VerifyNumVC.self, viewConrollerID: "VerifyNumVC")
                vc.mobileVerifyData = self.mobileVerifyData
                self.push(from: self, ToViewContorller: vc)
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func verifyNumber(mobileNum : String){
        self.presenter?.HITAPI(api: Base.generateOTP.rawValue, params: ["mobile":"\(mobileNum)"], methodType: .POST, modelClass: MobileVerifyModel.self, token: false)
    }
}

