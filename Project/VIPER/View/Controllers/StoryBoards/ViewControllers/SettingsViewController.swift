//
//  SettingsViewController.swift
//  MiDokter User
//
//  Created by Sethuram Vijayakumar on 10/11/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

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
        
        self.logout()
        
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
    
    
    private func logout() {
        
        let alert = UIAlertController(title: nil, message: Constants.string.areYouSureWantToLogout.localize(), preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: Constants.string.logout.localize(), style: .destructive) { (_) in
            self.presenter?.HITAPI(api: Base.logout.rawValue, params: nil, methodType: .POST, modelClass: LoginModel.self, token: false)
        }
        
        let cancelAction = UIAlertAction(title: Constants.string.Cancel.localize(), style: .cancel, handler: nil)
        
        alert.view.tintColor = .primary
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}


extension SettingsViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        DispatchQueue.main.async {
            forceLogout()
        }
    }
    
    func showError(error: CustomError) {
        showToast(msg: error.localizedDescription)
    }
    
    
}
