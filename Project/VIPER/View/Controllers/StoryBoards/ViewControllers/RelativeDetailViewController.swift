//
//  RelativeDetailViewController.swift
//  MiDokter User
//
//  Created by Sethuram Vijayakumar on 10/11/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class RelativeDetailViewController: UIViewController {

    @IBOutlet weak var personalBtn : UIButton!
    @IBOutlet weak var medicalBtn : UIButton!
    @IBOutlet weak var lifestyleBtn : UIButton!
    
    
    @IBOutlet weak var personalView : UIView!
    @IBOutlet weak var medicalView : UIView!
    @IBOutlet weak var lifestyleView : UIView!
    
    @IBOutlet weak var segmentProfile : UISegmentedControl!

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
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
    }

}


extension RelativeDetailViewController {
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction(sender:)))


      }
    
    func setupAction(){
        
        self.segmentAction(sender: self.segmentProfile)
        self.segmentProfile.setTitle("Personal".uppercased(), forSegmentAt: 0)
        self.segmentProfile.setTitle("Medical".uppercased(), forSegmentAt: 1)
        self.segmentProfile.setTitle("Lifestyle".uppercased(), forSegmentAt: 2)

    }
    
    
    @IBAction private func doneAction (sender : UIBarButtonItem){
        
        ///Functionality
    }
    
    @IBAction private func segmentAction (sender : UISegmentedControl){
        
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        sender.setTitleTextAttributes(titleTextAttributes, for: .highlighted)
        sender.setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.segmentProfile.selectedSegmentTintColor = .AppBlueColor
            self.personalView.isHidden = false
            [ self.lifestyleView,self.medicalView].forEach { (view) in view?.isHidden = true}
            break

        case 1:
            self.segmentProfile.selectedSegmentTintColor = .AppBlueColor
            self.medicalView.isHidden = false
            [ self.lifestyleView,self.personalView].forEach { (view) in view?.isHidden = true}
            break

        case 2:
            self.segmentProfile.selectedSegmentTintColor = .AppBlueColor
            self.lifestyleView.isHidden = false
            [ self.medicalView,self.personalView].forEach { (view) in view?.isHidden = true}
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


extension RelativeDetailViewController : UITextFieldDelegate {
    
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
