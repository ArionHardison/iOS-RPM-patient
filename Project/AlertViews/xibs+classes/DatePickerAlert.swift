//
//  DatePickerAlert.swift
//  MiDokter User
//
//  Created by AppleMac on 16/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class DatePickerAlert : UIView {
    
    @IBOutlet weak var TitleLbl : UILabel!
    @IBOutlet weak var submitBtn : UIButton!
    @IBOutlet weak var cancelBtn : UIButton!
    @IBOutlet weak var datepicker : UIDatePicker!
    
    
    var alertdelegate : AlertDelegate!
    var alertVC : UIViewController = UIViewController()
    var selectedDate : String = ""
    var selectedTime : String = ""
    
    
    override func initView(view : UIView , vc : UIViewController) -> UIView {
        self.alertVC = vc
        self.setupView(view: view)
        self.submitBtn.setCorneredElevation()
       
        self.datepicker.maximumDate = Date()
        
        self.setupAction()
        return self
    }
    
    
    
    
    override func deInitView(view : UIView , vc : UIViewController) -> UIView {
        return self
    }
    
    func setupAction(){
        
        self.cancelBtn.addTap {
             self.alertVC.dismiss(animated: false, completion: nil)
        }
        
        self.submitBtn.addTap{
            guard let delegate = self.alertdelegate else {
                self.alertVC.dismiss(animated: false, completion: nil)
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            self.selectedDate = dateFormatter.string(from: self.datepicker.date)
            
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "YYYY"
            
            
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MM"
            
            
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "dd"
            
            
            self.alertdelegate.selectedDate(date: dayFormatter.string(from: self.datepicker.date), month: monthFormatter.string(from: self.datepicker.date), year: yearFormatter.string(from: self.datepicker.date), dob: self.selectedDate, alertVC: self.alertVC)
             self.alertVC.dismiss(animated: false, completion: nil)
        }
    }
    
    func setupView(view : UIView){
        view.addSubview(self)
        view.bringSubview(toFront: self)
        let height =  self.frame.height < 150.0 ? 150 : self.frame.height
        self.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        self.transform = CGAffineTransform(translationX: 0, y: 0)
        
        self.backgroundColor = .white
        
        self.setCorneredElevation()
    }
    
    
    
    //MARK: Register xib view
    class var getView : DatePickerAlert {
        return UINib(nibName: "DatePickerAlert", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! DatePickerAlert
    }
}


class TimePickerAlert : UIView {
    
    @IBOutlet weak var TitleLbl : UILabel!
    @IBOutlet weak var submitBtn : UIButton!
    @IBOutlet weak var cancelBtn : UIButton!
    @IBOutlet weak var timepicker : UIDatePicker!
    
    
    var alertdelegate : AlertDelegate!
    var alertVC : UIViewController = UIViewController()
    var selectedtime : String = ""
    var schduleDate : Date = Date()
    
    override func initView(view : UIView , vc : UIViewController) -> UIView {
        self.alertVC = vc
        self.setupView(view: view)
        self.submitBtn.setCorneredElevation(shadow: 7, corner: 7, color: .clear)
        self.cancelBtn.setCorneredElevation(shadow: 7, corner: 7, color: .clear)

        self.submitBtn.setCorneredElevation()

        if schduleDate.interval(ofComponent: .day, fromDate: Date()) == 0{
            self.timepicker.minimumDate = Date()
        }
        
        self.setupAction()
        return self
    }
    
    
    
    
    override func deInitView(view : UIView , vc : UIViewController) -> UIView {
        return self
    }
    
    func setupAction(){
        
        self.cancelBtn.addTap {
            self.alertVC.dismiss(animated: false, completion: nil)
        }
        
        self.submitBtn.addTap{
            guard let delegate = self.alertdelegate else {
                self.alertVC.dismiss(animated: false, completion: nil)
                return
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            self.selectedtime = dateFormatter.string(from: self.timepicker.date)
            
            
            
            self.alertdelegate.selectedTime(time: self.selectedtime, alertVC: self.alertVC)
            self.alertVC.dismiss(animated: false, completion: nil)
        }
    }
    
    func setupView(view : UIView){
        view.addSubview(self)
        view.bringSubview(toFront: self)
        let height =  self.frame.height < 150.0 ? 150 : self.frame.height
        self.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        self.transform = CGAffineTransform(translationX: 0, y: 0)
        self.timepicker.tintColor = UIColor(named: "GreyTextcolor")
        self.backgroundColor = .white
        
        self.setCorneredElevation()
    }
    
    
    
    //MARK: Register xib view
    class var getView : TimePickerAlert {
        return UINib(nibName: "DatePickerAlert", bundle: nil).instantiate(withOwner: self, options: nil)[1] as! TimePickerAlert
    }
}
