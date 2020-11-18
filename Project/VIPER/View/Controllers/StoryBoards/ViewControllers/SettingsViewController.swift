//
//  SettingsViewController.swift
//  MiDokter User
//
//  Created by Sethuram Vijayakumar on 10/11/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var showReminderLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var ReminderSwitch: UISwitch!
    @IBOutlet weak var logOutButton: UIButton!
    
    var isSwitchON : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalLoads()
        self.setUpNavigation()
        self.addAction()
        
        
        // Do any additional setup after loading the view.
    }
    

    func addAction() {
        
        self.aboutLabel.addTap {
            self.privacyPolicyAction()
        }
    }

}


extension SettingsViewController {
    
    private func initalLoads(){
        self.showReminderLabel.text = "Show Reminder Notification"
        self.aboutLabel.text = "About TeleHealth"
        self.rateLabel.text = "Rate Us On AppStore"
        self.ReminderSwitch.addTarget(self, action: #selector(reminderAction(sender:)), for: .valueChanged)
        self.logOutButton.addTarget(self, action: #selector(logoutAction(sender:)), for: .touchUpInside)
        
        
    }
    private func setUpNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Settings"
    }
    
    @IBAction private func reminderAction(sender:UISwitch){
        
        self.isSwitchON = !isSwitchON
        sender.isOn = !isSwitchON
        
    }
    
    @IBAction private func logoutAction(sender:UIButton){
        
        forceLogout()
        
    }
    
    
    private func privacyPolicyAction(){
        
        let url = URL(string: aboutUrl)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            //If you want handle the completion block than
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                 print("Open url : \(success)")
            })
        }
        
    }
    
    
}
