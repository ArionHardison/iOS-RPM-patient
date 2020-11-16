//
//  SigninInViewController.swift
//  Project
//
//  Created by Chan Basha on 04/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper
import IQKeyboardManagerSwift
import SKCountryPicker

class SigninInViewController: UIViewController {

    
    @IBOutlet weak var labelMobileNumber: UILabel!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var buttonContinue: UIButton!
    @IBOutlet weak var buttonTrouble: UIButton!
    @IBOutlet weak var labelLoginUsing: UILabel!
    @IBOutlet weak var labelFB: UILabel!
    @IBOutlet weak var labelGoogle: UILabel!
    @IBOutlet weak var labelTermsAndConditions: UILabel!
    @IBOutlet weak var countryCode : UIView!
    @IBOutlet weak var mobileView : UIView!
    @IBOutlet weak var countryImg : UIImageView!
    @IBOutlet weak var countryCodeLbl : UILabel!
    @IBOutlet weak var appleView: UIView!
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    
    
    func initialLoads(){
        self.setupAction()
        self.setupTextDelegate()
        self.setupCountryPicker()
        
        self.mobileView.cornerRadius = 5.0
        
    }
    
    func setupAction(){
        self.buttonContinue.addTap {
            self.view.endEditing(true)
            
//            self.setupCountryPicker()
            if self.txtMobileNumber.getText.isEmpty || self.txtMobileNumber.getText.count < mobileNumDigit{
                showToast(msg: "Enter Valid MobileNumber")
            }else{
//                var countrycode : String = self.countryCode.countryDetailsLabel.getText
                var countrycode : String = self.countryCodeLbl.text ?? "" // self.countryCode.countryDetailsLabel.getText

//                if countrycode.contains("+"){
//                    countrycode = countrycode.replacingOccurrences(of: "+", with: "")
//                }
                self.verifyNumber(mobileNum: "\(countrycode)\(self.txtMobileNumber.getText)")
             }
        }
    }

}


extension SigninInViewController{


    func setupCountryPicker(){
        self.countryCode.addTap {
            
            CountryPickerWithSectionViewController.presentController(on: self) { (country) in

                self.countryCodeLbl.text = country.dialingCode
                self.countryImg.image = country.flag

            }
        }
        guard let country = CountryManager.shared.currentCountry else {
             return
         }

        self.countryCodeLbl.text = country.dialingCode
        self.countryImg.image = country.flag
   
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
                var countrycode : String = self.countryCodeLbl.text ?? "" //self.countryCode.countryDetailsLabel.getText
//                if countrycode.contains("+"){
//                    countrycode = countrycode.replacingOccurrences(of: "+", with: "")
//                }
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

