//
//  NameAndEmailViewController.swift
//  Project
//
//  Created by Chan Basha on 04/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class NameAndEmailViewController: UIViewController {
    
    
    var count = 0
    
    
    @IBOutlet weak var buttonBack: UIButton!
    
    @IBOutlet weak var labelCount: UILabel!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var buttonContinue: UIButton!
    
    @IBOutlet weak var buttonAcceptance: UIButton!
    
    @IBOutlet weak var labelOffers: UILabel!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var firstNameView: UIView!
    
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
        if self.txtName.getText.isEmpty || self.txtName.getText.count < 3{
            showToast(msg: "Enter Your First Name")
        }else{
            if self.lastName.getText.isEmpty || self.lastName.getText.count < 3{
                showToast(msg: "Enter Your Last Name")
            }else{
            self.signupReq?.first_name = self.txtName.getText
                self.signupReq?.last_name = self.lastName.getText
            let vc = EmailViewController.initVC(storyBoardName: .user, vc: EmailViewController.self, viewConrollerID: Storyboard.Ids.EmailViewController)
            vc.signupReq = self.signupReq
            self.push(from: self, ToViewContorller: vc)
            }
        }
        
        
    }
    
    @IBAction func backAction(sender:UIButton){
        
        backButtonClick()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }


}
extension NameAndEmailViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtName{
            self.lastName.becomeFirstResponder()
        }else{
            self.view.endEditing(true)
        }
        return true
    }
    
    func setupDelegate(){
        self.txtName.delegate = self
        self.lastName.delegate = self
    }
}
