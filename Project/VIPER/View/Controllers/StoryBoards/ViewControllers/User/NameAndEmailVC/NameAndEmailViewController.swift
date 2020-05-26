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
    
    @IBOutlet weak var buttonContinue: UIButton!
    
    @IBOutlet weak var buttonAcceptance: UIButton!
    
    @IBOutlet weak var labelOffers: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        buttonBack.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        buttonContinue.addTarget(self, action: #selector(continueAction(sender:)), for: .touchUpInside)
    }
    

   @IBAction func continueAction(sender:UIButton){
          
          self.push(id: Storyboard.Ids.GenderConfirmationVC, animation: true)
          
      }
    
    @IBAction func backAction(sender:UIButton){
        
        backButtonClick()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }


}
