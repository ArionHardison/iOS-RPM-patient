//
//  ReminderDetailViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 13/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class ReminderDetailViewController: UIViewController {
    
    
    @IBOutlet weak var reminderNameLbl : UILabel!
    @IBOutlet weak var reminderNameTXf : UITextField!
    @IBOutlet weak var DateTitleLbl : UILabel!
    @IBOutlet weak var dateTxt : UITextField!
    @IBOutlet weak var TimeTitleLbl : UILabel!
    @IBOutlet weak var timeTxt : UITextField!
    @IBOutlet weak var alaramTitleLbl : UILabel!
    @IBOutlet weak var NotifyTitleLbl : UILabel!
    @IBOutlet weak var alaramSwiftch : UISwitch!
    @IBOutlet weak var NotifySwiftch : UISwitch!

    
    
    var isNewReminder : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initailSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
    }

    func initailSetup(){
        self.setupNavigation()
        Common.setFont(to: self.reminderNameLbl, isTitle: false, size: 14)
        Common.setFont(to: self.reminderNameTXf, isTitle: true, size: 17)
        Common.setFont(to: self.DateTitleLbl, isTitle: false, size: 17)
        Common.setFont(to: self.dateTxt, isTitle: true, size: 17)
        Common.setFont(to: self.TimeTitleLbl, isTitle: false, size: 17)
        Common.setFont(to: self.timeTxt, isTitle: true, size: 17)
        Common.setFont(to: self.alaramTitleLbl, isTitle: false, size: 17)
        Common.setFont(to: self.NotifyTitleLbl, isTitle: false, size: 17)
    }
    
    func setupNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        if isNewReminder{
            self.title = "New"
        }else{
            self.title = "Reminder Name"
        }
    }
}
