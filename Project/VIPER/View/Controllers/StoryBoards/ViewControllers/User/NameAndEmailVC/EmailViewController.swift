//
//  EmailViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 15/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {

    
    @IBOutlet weak var buttonBack: UIButton!
    
    @IBOutlet weak var labelCount: UILabel!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var buttonContinue: UIButton!
    
    
     var signupReq: SignupReq?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDelegate()
        // Do any additional setup after loading the view.
        
        
        buttonBack.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        buttonContinue.addTarget(self, action: #selector(continueAction(sender:)), for: .touchUpInside)
    }
    
    
    @IBAction func continueAction(sender:UIButton){
        self.view.endEditing(true)
        if self.emailTxt.getText.isEmpty || !(self.emailTxt.getText.isValidEmail()){
            showToast(msg: "Enter Valid Email Address")
        }else{
            self.signupReq?.email = self.emailTxt.getText
            let vc = GenderConfirmationVC.initVC(storyBoardName: .user, vc: GenderConfirmationVC.self, viewConrollerID: Storyboard.Ids.GenderConfirmationVC)
            vc.signupReq = self.signupReq
            self.push(from: self, ToViewContorller: vc)
        }
        
    }
    
    @IBAction func backAction(sender:UIButton){
        
        backButtonClick()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
}

extension EmailViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    func setupDelegate(){
        self.emailTxt.delegate = self
    }
}
