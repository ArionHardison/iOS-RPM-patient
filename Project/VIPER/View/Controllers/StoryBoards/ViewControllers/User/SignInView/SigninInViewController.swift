//
//  SigninInViewController.swift
//  Project
//
//  Created by Chan Basha on 04/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class SigninInViewController: UIViewController {

    
    @IBOutlet weak var labelMobileNumber: UILabel!
    
    @IBOutlet weak var txtCountryCode: UITextField!
    
    
    @IBOutlet weak var txtMobileNumber: UITextField!
    
    @IBOutlet weak var buttonContinue: UIButton!
    
    @IBOutlet weak var buttonTrouble: UIButton!
    
    @IBOutlet weak var labelLoginUsing: UILabel!
    
    @IBOutlet weak var labelFB: UILabel!
    
    @IBOutlet weak var labelGoogle: UILabel!
    
    @IBOutlet weak var labelTermsAndConditions: UILabel!
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    

   

    @IBAction func continueAction(sender:UIButton){
        
        self.push(id: Storyboard.Ids.NameAndEmailViewController, animation: true)
        
    }
    
    @IBAction func backAction(sender:UIButton){
           
           backButtonClick()
           
       }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
