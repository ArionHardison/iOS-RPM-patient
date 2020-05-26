//
//  GenderConfirmationVC.swift
//  Project
//
//  Created by Chan Basha on 04/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class GenderConfirmationVC: UIViewController {
    
    
    @IBOutlet weak var buttonBack: UIButton!
    
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var btnMale: UIButton!
    
    @IBOutlet weak var btnFemale: UIButton!
    
    @IBOutlet weak var btnOthers: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        buttonBack.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        btnMale.addTarget(self, action: #selector(continueAction(sender:)), for: .touchUpInside)
        btnFemale.addTarget(self, action: #selector(continueAction(sender:)), for: .touchUpInside)
        btnOthers.addTarget(self, action: #selector(continueAction(sender:)), for: .touchUpInside)
    }
    

    @IBAction func continueAction(sender:UIButton){
          
          self.push(id: Storyboard.Ids.DateOfBirthViewController, animation: true)
          
      }
    
    @IBAction func backAction(sender:UIButton){
        
        backButtonClick()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }


}
