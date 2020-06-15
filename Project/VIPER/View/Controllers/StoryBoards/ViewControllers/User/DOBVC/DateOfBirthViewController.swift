//
//  DateOfBirthViewController.swift
//  Project
//
//  Created by Chan Basha on 04/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class DateOfBirthViewController: UIViewController {

    @IBOutlet weak var buttonBack: UIButton!
    
    
    @IBOutlet weak var labelCount: UILabel!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var txtdate: UITextField!
    
    @IBOutlet weak var txtMonth: UITextField!
    
    @IBOutlet weak var txtYear: UITextField!
    
    @IBOutlet weak var btnContinue: UIButton!
    
    
    var signupReq: SignupReq?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("SignupData",self.signupReq)
        
        buttonBack.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        btnContinue.addTarget(self, action: #selector(continueAction(sender:)), for: .touchUpInside)
    }
    

    @IBAction func continueAction(sender:UIButton){
            
        
//        DispatchQueue.main.async {
//
//            let drawer = Common.setDrawerController() //Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.DrawerController)
//            drawer.modalPresentationStyle = .currentContext
//
//
//
//            self.present(drawer, animated: true, completion: {
//            self.navigationController?.viewControllers.removeAll()
//            })
//
//        }
        
          self.navigationController?.present(Common.setDrawerController(), animated: true, completion: nil)
        
        
             
    }
       
       @IBAction func backAction(sender:UIButton){
           
           backButtonClick()
           
       }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }


}
