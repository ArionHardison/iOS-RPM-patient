//
//  ReminderDetailViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 13/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper
import IQKeyboardManagerSwift

class ReminderDetailViewController: UIViewController {
    
    
    @IBOutlet weak var reminderNameLbl : UILabel!
    @IBOutlet weak var reminderNameTXf : HoshiTextField!
    @IBOutlet weak var DateTitleLbl : UILabel!
    @IBOutlet weak var dateTxt : UITextField!
    @IBOutlet weak var TimeTitleLbl : UILabel!
    @IBOutlet weak var timeTxt : UITextField!
    @IBOutlet weak var alaramTitleLbl : UILabel!
    @IBOutlet weak var NotifyTitleLbl : UILabel!
    @IBOutlet weak var alaramSwiftch : UISwitch!
    @IBOutlet weak var NotifySwiftch : UISwitch!

    
    var selectedDate : String = ""
    var selectedTime : String = ""
    var isNewReminder : Bool = false
    var isAlarm : Bool = false
    var isNotify : Bool = false
    var remainder : Reminder?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initailSetup()
        self.dateTxt.delegate = self
        self.timeTxt.delegate = self
        IQKeyboardManager.shared.enable = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
}



extension ReminderDetailViewController {
    
    func initailSetup(){
        self.setupNavigation()
//        Common.setFont(to: self.DateTitleLbl, isTitle: false, size: 17)
//        Common.setFont(to: self.dateTxt, isTitle: true, size: 17)
//        Common.setFont(to: self.TimeTitleLbl, isTitle: false, size: 17)
//        Common.setFont(to: self.timeTxt, isTitle: true, size: 17)
//        Common.setFont(to: self.alaramTitleLbl, isTitle: false, size: 17)
//        Common.setFont(to: self.NotifyTitleLbl, isTitle: false, size: 17)
        self.alaramSwiftch.setOn(isAlarm, animated: true)
        self.NotifySwiftch.setOn(isNotify, animated: true)
        self.alaramSwiftch.addTarget(self, action: #selector(alarmAction(sender:)), for: .valueChanged)
        self.NotifySwiftch.addTarget(self, action: #selector(notifyAction(sender:)), for: .valueChanged)
        self.reminderNameTXf.isUserInteractionEnabled = isNewReminder
        self.dateTxt.isUserInteractionEnabled = isNewReminder
        self.timeTxt.isUserInteractionEnabled = isNewReminder
        self.alaramSwiftch.isUserInteractionEnabled = isNewReminder
        self.NotifySwiftch.isUserInteractionEnabled = isNewReminder
        self.setData()

    }
    
    func setupNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        if isNewReminder{
            self.title = "New"
        }else{
            self.title = "Remainder Name"
        }
        if isNewReminder{
        let doneButton : UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneAction(sender:)))
        self.navigationItem.rightBarButtonItem = doneButton
        }
    }

    
    @IBAction private func doneAction(sender:UIBarButtonItem){
        
        guard let remaninder = self.reminderNameTXf.text,!remaninder.isEmpty else{
            showToast(msg: "Enter Remainder Text")
            return
        }
        
        guard let date = self.dateTxt.text, !date.isEmpty else {
            showToast(msg: "Enter Date")
            return
        }
        
        guard  let time = self.timeTxt.text, !time.isEmpty else {
            showToast(msg: "Enter Time")
            return
        }
        
        var params = [String:Any]()
        params.updateValue(remaninder, forKey: "name")
        params.updateValue(date, forKey: "date")
        params.updateValue(time, forKey: "time")
        params.updateValue(isAlarm ? 1 : 0, forKey: "alarm")
        params.updateValue(isNotify ? 1 : 0, forKey: "notify_me")
        self.presenter?.HITAPI(api: Base.addRemainder.rawValue, params: params, methodType: .POST, modelClass: RemainderSuccess.self, token: true)
        
    }
    
    private func setData(){
        if !isNewReminder {
            self.reminderNameTXf.text = self.remainder?.name ?? ""
            self.dateTxt.text = self.remainder?.date ?? ""
            self.timeTxt.text = self.remainder?.time ?? ""
            isAlarm = (self.remainder?.alarm ?? 0) == 1 ? true : false
            isNotify = (self.remainder?.notify_me ?? 0) == 1 ? true : false
            self.alaramSwiftch.setOn(isAlarm, animated: true)
            self.NotifySwiftch.setOn(isNotify, animated: true)
            
        }
    }
    
    @IBAction private func alarmAction(sender:UISwitch){
        isAlarm = !isAlarm
        self.alaramSwiftch.setOn(isAlarm, animated: true)
           
    }
    
    @IBAction private func notifyAction(sender:UISwitch){
        isNotify = !isNotify
        self.NotifySwiftch.setOn(isNotify, animated: true)
    }
    
    
    
}



extension ReminderDetailViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dateTxt{
            let view = DatePickerAlert.getView
                view.alertdelegate = self
            AlertBuilder().addView(fromVC: self , view).show()
            return false
        }else if textField == timeTxt{
            let view = TimePickerAlert.getView
                view.alertdelegate = self
            AlertBuilder().addView(fromVC: self , view).show()
            return false
        }
        
        return true
    }
    
    
    
    
}


extension ReminderDetailViewController : AlertDelegate{
    func selectedDate(date: String, month: String, year: String, dob: String, alertVC: UIViewController) {
        self.selectedDate = dob
        self.dateTxt.text = dob
    }
    
    func selectedTime(time: String, alertVC: UIViewController) {
        self.selectedTime = time
        self.timeTxt.text = time
    }
    
    
}


extension ReminderDetailViewController : PresenterOutputProtocol {
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
          switch String(describing: modelClass) {
           
              
                      case model.type.TwilioAccess:
                      guard let data = dataDict as? RemainderSuccess else { return }
                      showToast(msg: "SucessFully Added")
                      if data.status == 200 {
                        self.navigationController?.popViewController(animated: true)
                      }
             
               break
              default: break
          }
    }
    
    func showError(error: CustomError) {
        showToast(msg: error.localizedDescription)
    }
    
    
}
