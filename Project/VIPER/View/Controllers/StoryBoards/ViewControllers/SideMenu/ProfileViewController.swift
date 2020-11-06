//
//  ProfileViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 17/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

enum ProfileViewOption{
    case personal
    case medical
    case lifestyle
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var personalBtn : UIButton!
    @IBOutlet weak var medicalBtn : UIButton!
    @IBOutlet weak var lifestyleBtn : UIButton!
    
    
    @IBOutlet weak var personalView : UIView!
    @IBOutlet weak var medicalView : UIView!
    @IBOutlet weak var lifestyleView : UIView!
    
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var nameTxt : HoshiTextField!
    @IBOutlet weak var contantNumTxt : HoshiTextField!
    @IBOutlet weak var emailidTxt : HoshiTextField!
    @IBOutlet weak var genderTxt : HoshiTextField!
    @IBOutlet weak var dobTXT : HoshiTextField!
    @IBOutlet weak var bloodgroupTxt : HoshiTextField!
    @IBOutlet weak var maritalStateTxt : HoshiTextField!
    @IBOutlet weak var heightTxt : HoshiTextField!
    @IBOutlet weak var weightTxt : HoshiTextField!
    @IBOutlet weak var emergencyTxt : HoshiTextField!
    @IBOutlet weak var locationTxt : HoshiTextField!
    
    
    @IBOutlet weak var allergiesTxt : HoshiTextField!
    @IBOutlet weak var currentMedicnTxt : HoshiTextField!
    @IBOutlet weak var pastMedicnTxt : HoshiTextField!
    @IBOutlet weak var chronicTxt : HoshiTextField!
    @IBOutlet weak var injuriesTxt : HoshiTextField!
    @IBOutlet weak var surgeriesTxt : HoshiTextField!
    
    
    @IBOutlet weak var smokinghabitTxt : HoshiTextField!
    @IBOutlet weak var alcoholTxt : HoshiTextField!
    @IBOutlet weak var activityTxt : HoshiTextField!
    @IBOutlet weak var foodPreferenceTxt : HoshiTextField!
    @IBOutlet weak var occupationTxt : HoshiTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
    }
    
    func initialLoad()  {
        self.setupNavigation()
        self.setupAction()
        self.setValues()
        IQKeyboardManager.shared.enable = false
        self.dobTXT.delegate = self
    }
    
    func setupNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Your Profile"
        self.viewOption(option: .personal)
      }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
    }
    
    func setupAction(){
        self.personalBtn.addTap {
            self.viewOption(option: .personal)
        }
        
        self.medicalBtn.addTap {
            self.viewOption(option: .medical)
            
        }
        
        self.lifestyleBtn.addTap {
            self.viewOption(option: .lifestyle)
            
        }
    }

    func viewOption(option : ProfileViewOption){
        switch option {
            case .personal:
                self.personalBtn.setCorneredElevation(shadow: 1, corner: 5, color: .clear)
                self.personalBtn.backgroundColor = UIColor.AppBlueColor
                self.personalBtn.setTitleColor(UIColor.white, for: .normal)
                self.personalView.isHidden = false
                self.lifestyleView.isHidden = true
                self.medicalView.isHidden = true
                
                [ self.lifestyleBtn,self.medicalBtn].forEach { (button) in
                    button?.setCorneredElevation(shadow: 0, corner: 0, color: .clear)
                    button?.backgroundColor = UIColor.white
                    button?.setTitleColor(UIColor.darkGray, for: .normal)
                }
            break
            case .lifestyle:
                self.lifestyleBtn.setCorneredElevation(shadow: 1, corner: 5, color: .clear)
                self.lifestyleBtn.backgroundColor = UIColor.AppBlueColor
                self.lifestyleBtn.setTitleColor(UIColor.white, for: .normal)
                self.personalView.isHidden = true
                self.lifestyleView.isHidden = false
                self.medicalView.isHidden = true
                [ self.personalBtn,self.medicalBtn].forEach { (button) in
                    button?.setCorneredElevation(shadow: 0, corner: 0, color: .clear)
                    button?.backgroundColor = UIColor.white
                    button?.setTitleColor(UIColor.darkGray, for: .normal)
                }
            break
            case .medical:
                self.medicalBtn.setCorneredElevation(shadow: 1, corner: 5, color: .clear)
                self.medicalBtn.backgroundColor = UIColor.AppBlueColor
                self.medicalBtn.setTitleColor(UIColor.white, for: .normal)
                self.personalView.isHidden = true
                self.lifestyleView.isHidden = true
                self.medicalView.isHidden = false
                [ self.lifestyleBtn,self.personalBtn].forEach { (button) in
                    button?.setCorneredElevation(shadow: 0, corner: 0, color: .clear)
                    button?.backgroundColor = UIColor.white
                    button?.setTitleColor(UIColor.darkGray, for: .normal)
                }
            break
            default:
            break
        }
    }
    
    private func setValues(){
        if let profile : ProfileModel = profileDetali{
            self.nameTxt.text = "\(profile.patient?.first_name ?? "") \(profile.patient?.last_name ?? "")"
            self.emailidTxt.text = "\(profile.patient?.email ?? "")"
            self.contantNumTxt.text = "\(profile.patient?.phone ?? "")"
            self.profileImage.setURLImage(profile.patient?.profile?.profile_pic ?? "")
            self.genderTxt.text = "\(profile.patient?.profile?.gender ?? "")"
            self.bloodgroupTxt.text = "\(profile.patient?.profile?.blood_group ?? "")"
            self.dobTXT.text = "\(profile.patient?.profile?.dob ?? "")"
            self.locationTxt.text = "\(profile.patient?.profile?.address ?? "")"
        }
    }
    
}


extension ProfileViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dobTXT{
            PickerManager.shared.showDatePicker(selectedDate: textField.text, completionHandler: { date in
                textField.text = date
                
            })
            return false
            
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       // Try to find next responder
       if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
          nextField.becomeFirstResponder()
       } else {
          // Not found, so remove keyboard.
          textField.resignFirstResponder()
       }
       // Do not add a line break
       return false
    }
}
