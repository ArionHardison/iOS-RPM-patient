//
//  ProfileViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 17/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import ObjectMapper
import GooglePlaces
//
//enum ProfileViewOption{
//    case personal = "Personal"
//    case medical = "Medical"
//    case lifestyle = "Lifestyle"
//}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var personalBtn : UIButton!
    @IBOutlet weak var medicalBtn : UIButton!
    @IBOutlet weak var lifestyleBtn : UIButton!
    
    @IBOutlet weak var alcoholYesBtn : UIButton!
    @IBOutlet weak var smokeYesBtn : UIButton!
//    @IBOutlet weak var smokeImg : UIImageView!
//    @IBOutlet weak var alcohoImg : UIImageView!

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
    
    @IBOutlet weak var alchoholLbl : UILabel!
    @IBOutlet weak var smokingLbl : UILabel!

    
//    @IBOutlet weak var smokinghabitTxt : HoshiTextField!
//    @IBOutlet weak var alcoholTxt : HoshiTextField!
    @IBOutlet weak var activityTxt : HoshiTextField!
    @IBOutlet weak var foodPreferenceTxt : HoshiTextField!
    @IBOutlet weak var occupationTxt : HoshiTextField!
    
//    var value  : [ProfileViewOption]!
    var isSmoking : Bool = false
    var isAlchol : Bool = false
    var martialStatusArray = ["Single","Married","Others"]
    var dlat : Double?
    var dlon : Double?
    var dAddress = String()
    var updateProfile = UIImage()
    var genderArray = ["Male","Female","Other"]
    private var googlePlacesHelper : GooglePlacesHelper?
    var allergies = [String]()
    private lazy var loader : UIView = {
        return createActivityIndicator(UIScreen.main.focusedView ?? self.view)
    }()
    
    let checkedImg = UIImage(systemName: "checkmark.circle.fill") //UIImage(named: "")
    let uncheckedImg = UIImage(systemName: "circle") //UIImage(named: "circle")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
    }
    
    func initialLoad()  {
        self.googlePlacesHelper = GooglePlacesHelper()
        self.setupNavigation()
        self.setupAction()
        self.setValues()
        IQKeyboardManager.shared.enable = true
        self.dobTXT.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(updateImage))
        self.profileImage.isUserInteractionEnabled = true
        self.profileImage.addGestureRecognizer(tap)
        self.allergiesTxt.delegate = self
        self.locationTxt.delegate = self
        self.maritalStateTxt.delegate = self
        self.genderTxt.delegate = self
        

        self.getTextfield(view: self.view).forEach { (text) in Common.setFontWithType(to: text, size: 14, type: .regular)}
//            Common.setFontWithType(to: (text.placeholder)!, size: 16, type: .meduim)
            
        [self.smokingLbl,self.alchoholLbl].forEach { (text) in Common.setFontWithType(to: text!, size: 16, type: .regular)}
       
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.profileImage.makeRoundedCorner()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
        
    }
    
    private func setValues(){
         let profile : ProfileModel = profileDetali
            self.nameTxt.text = "\(profile.patient?.first_name ?? "") \(profile.patient?.last_name ?? "")"
            self.emailidTxt.text = "\(profile.patient?.email ?? "")"
            self.contantNumTxt.text = "\(profile.patient?.phone ?? "")"
            self.profileImage.setURLImage(profile.patient?.profile?.profile_pic ?? "")
            self.genderTxt.text = "\(profile.patient?.profile?.gender ?? "")"
            self.bloodgroupTxt.text = "\(profile.patient?.profile?.blood_group ?? "")"
            self.dobTXT.text = "\(profile.patient?.profile?.dob ?? "")"
            self.locationTxt.text = "\(profile.patient?.profile?.address ?? "")"
            self.maritalStateTxt.text = profile.patient?.profile?.merital_status ?? ""
            self.weightTxt.text = profile.patient?.profile?.weight ?? ""
            self.heightTxt.text = profile.patient?.profile?.height ?? ""
            self.emergencyTxt.text = profile.patient?.profile?.emergency_contact ?? ""
            self.allergiesTxt.text = profile.patient?.profile?.allergies ?? ""
            self.currentMedicnTxt.text = profile.patient?.profile?.current_medications ?? ""
            self.pastMedicnTxt.text = profile.patient?.profile?.past_medications ?? ""
            self.chronicTxt.text = profile.patient?.profile?.chronic_diseases ?? ""
            self.injuriesTxt.text = profile.patient?.profile?.injuries ?? ""
            self.surgeriesTxt.text = profile.patient?.profile?.surgeries ?? ""
            self.isSmoking = profile.patient?.profile?.smoking == "false" ? false : true
            self.isAlchol = profile.patient?.profile?.alcohol == "false" ? false : true
            self.activityTxt.text = profile.patient?.profile?.activity ?? ""
            self.foodPreferenceTxt.text = profile.patient?.profile?.food ?? ""
            self.occupationTxt.text = profile.patient?.profile?.occupation ?? ""
            self.alcoholYesBtn.setImage(!isAlchol ? uncheckedImg : checkedImg, for: .normal)
            self.smokeYesBtn.setImage(!isSmoking ? uncheckedImg : checkedImg, for: .normal)
    }
    
   @objc private func updateValues(){
        guard  let name = self.nameTxt.text , !name.isEmpty  else {
            showToast(msg: "Enter Name")
            return
        }
    
    if !name.isEmpty {
//        let pattern = "/^[A-Z][a-z]{0,19}[\\s,][A-Z][a-z]{0,19}$/"
//        let predicate = NSPredicate(format: "self MATCHES [c] %@", pattern)
        if self.nameTxt.getText.contains(" ") {
            print("Valid")
            
        }
        else {
            print("Invalid")
            showToast(msg: "Enter the First Name,Last Name with space between them")
            return
        }
    }
        let fullNameArr = name.components(separatedBy: " ")
        let firstName = fullNameArr[0]
        let lastName = fullNameArr[1]
        guard  let phoneNumber = self.contantNumTxt.text,!phoneNumber.isEmpty else {
            showToast(msg: "Enter Mobile Number")
            return
        }
        guard  let email = self.emailidTxt.text,!email.isEmpty else {
            showToast(msg: "Enter Mail ID")
            return
        }
        guard let gender = self.genderTxt.text ,!gender.isEmpty else {
            showToast(msg: "Enter Gender")
            return
        }
        guard let dob = self.dobTXT.text,!dob.isEmpty else {
            showToast(msg: "Enter DOB")
            return
        }
        
        guard let bloodGroup = self.bloodgroupTxt.text,!bloodGroup.isEmpty else {
            showToast(msg: "Enter Blood Group")
            return
        }
        
        guard let marital_status = self.maritalStateTxt.text, !marital_status.isEmpty else {
            showToast(msg: "Enter Martial Status")
            return
        }
        
        guard let height = self.heightTxt.text, !height.isEmpty else {
            showToast(msg: "Enter Height")
            return
        }
        
        guard  let weight = self.weightTxt.text, !weight.isEmpty else {
            showToast(msg: "Enter Weight")
            return
        }
        
        guard  let emergency_contact = self.emergencyTxt.text, !emergency_contact.isEmpty else {
            showToast(msg: "Enter Emergency Contact")
            return
        }
        
        guard  let location = self.locationTxt.text else { //, !location.isEmpty
            showToast(msg: "Enter Location")
            return
        }
        guard  let allergies = self.allergiesTxt.text, !allergies.isEmpty else {
            showToast(msg: "Enter Allergies")
            return
        }
        var imageData = [String:Data]()
        imageData.updateValue(self.profileImage.image?.pngRepresentationData ?? Data(), forKey: "profile_pic")
        
        var params = [String:Any]()
        params.updateValue(firstName, forKey: "first_name")
        params.updateValue(lastName, forKey: "last_name")
        params.updateValue(phoneNumber, forKey: "phone")
        params.updateValue(email, forKey: "email")
        params.updateValue(gender, forKey: "gender")
        params.updateValue(dob, forKey: "dob")
        params.updateValue(bloodGroup, forKey: "blood_group")
        params.updateValue(marital_status, forKey: "merital_status")
        params.updateValue(height, forKey: "height")
        params.updateValue(weight, forKey: "weight")
        params.updateValue(emergency_contact, forKey: "emergency_contact")
        params.updateValue(location, forKey: "location")
        params.updateValue(allergies, forKey: "allergies")
        params.updateValue(currentMedicnTxt.text ?? "", forKey: "current_medications")
        params.updateValue(pastMedicnTxt.text ?? "", forKey: "past_medications")
        params.updateValue(chronicTxt.text ?? "", forKey: "chronic_diseases")
        params.updateValue(injuriesTxt.text ?? "", forKey: "injuries")
        params.updateValue(surgeriesTxt.text ?? "", forKey: "surgeries")
        params.updateValue(isSmoking ? "YES" : "NO", forKey: "smoking")
        params.updateValue(isAlchol ? "YES" : "NO", forKey: "alcohol")
        params.updateValue(activityTxt.text ?? "", forKey: "activity")
        params.updateValue(foodPreferenceTxt.text ?? "", forKey: "food")
        params.updateValue(occupationTxt.text ?? "", forKey: "occupation")
        print("Profile Update",params)
        self.presenter?.IMAGEPOST(api: Base.profile.rawValue, params: params, methodType: .POST, imgData: imageData, imgName: "profile_pic", modelClass: ProfileModel.self, token: true)
    self.loader.isHidden = false
        
    }
    
}


extension ProfileViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
          if textField == dobTXT{
              PickerManager.shared.showDatePicker(selectedDate: textField.text, completionHandler: { date in
                  textField.text = date
                  
              })
              return false
              
          }else if textField == maritalStateTxt {
              
              PickerManager.shared.showPicker(pickerData: martialStatusArray, selectedData: textField.text, completionHandler: { selectedData in
                  textField.text = selectedData
                  
              })
              return false
          }else if textField == self.locationTxt {
              self.googlePlacesHelper?.getGoogleAutoComplete(completion: { (place) in
                  self.dAddress = place.formattedAddress ?? ""
                textField.text = place.formattedAddress ?? ""
                  self.dlat = place.coordinate.latitude
                  self.dlon = place.coordinate.longitude
              })
              return false
          }else if textField == self.allergiesTxt {
//            self.present(id: "AllergyViewController", animation: true)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllergyViewController") as! AllergyViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.onClickDone = { content in
                self.allergies = content
                print(self.allergies)
                textField.text = self.allergies.joined(separator: ",")
                vc.dismiss(animated: true, completion: nil)
                
                
            }
            vc.onClickCancel = { content in
                textField.text = content
                vc.dismiss(animated: true, completion: nil)
                
            }
            self.present(vc, animated: true, completion: nil)
            
            return false
          }else if textField == self.genderTxt {
            PickerManager.shared.showPicker(pickerData: self.genderArray, selectedData: textField.text, completionHandler: { selectedData in
                textField.text = selectedData
                
                
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


// MARK:- Basha

extension ProfileViewController{
    func setupNavigation(){
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Your Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction(sender:)))
      }
    
    @IBAction private func doneAction (sender : UIBarButtonItem){
        
        ///Functionality
        self.updateValues()
    }
    
    func setupAction(){
        
        self.segmentAction(sender: self.segmentProfile)
        self.segmentProfile.setTitle("Personal".uppercased(), forSegmentAt: 0)
        self.segmentProfile.setTitle("Medical".uppercased(), forSegmentAt: 1)
        self.segmentProfile.setTitle("Lifestyle".uppercased(), forSegmentAt: 2)
        
        [self.alcoholYesBtn,self.smokeYesBtn].forEach { (btn) in

            if #available(iOS 14.0, *) {
                btn?.menu = UIMenu(title: btn?.tag == 101 ? "Do you have the habit of consuming alcohol?" : "Do you have the habit of smoking?", options: .displayInline, children: [

                    UIAction(title: Constants.string.Yes.localize(), image: checkedImg, handler: { [self] (action) in

                        btn?.setImage(checkedImg, for: .normal)


                    }),

                    UIAction(title: Constants.string.No.localize(), image: uncheckedImg, handler: { [self] (action) in

                        btn?.setImage(uncheckedImg, for: .normal)

                    })
                ])
                
                btn?.showsMenuAsPrimaryAction = true

            } else {
                
                btn?.addTap {
                    showAlert(message: btn?.tag == 101 ? "Do you have the habit of consuming alcohol?" : "Do you have the habit of smoking?", btnHandler: { [self] (value) in
                  
                        if value == 101 {
                            btn?.setImage(value == 1 ? checkedImg : uncheckedImg, for: .normal)
                            self.isSmoking = value == 1 ? true : false
                        }else{
                            btn?.setImage(value == 1 ? checkedImg : uncheckedImg, for: .normal)
                            self.isAlchol = value == 1 ? true : false
                        }
                        
                    }, fromView: self)
                    
                }

            }

                
        }

    }
    
    
    @objc private func updateImage(){
        self.showImage { (image) in
            self.updateProfile = image!
            self.profileImage.image = self.updateProfile
        }
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
    
    


}
extension ProfileViewController : PresenterOutputProtocol {
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.ProfileModel:
                let data = dataDict as? ProfileModel
                UserDefaultConfig.PatientID = (data?.patient?.id ?? 0).description
                profileDetali = data ?? ProfileModel()
                self.loader.isHideInMainThread(true)
                showToast(msg: "Profile Updated Sucessfully")
//                self.setValues()
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        showToast(msg: error.localizedDescription)
    }
    
        
}


extension UIImage {

    var pngRepresentationData: Data? {
        return UIImagePNGRepresentation(self)
    }

    var jpegRepresentationData: Data? {
        return UIImageJPEGRepresentation(self, 1.0)
    }
}



extension ProfileViewController{
    
    func getTextfield(view: UIView) -> [HoshiTextField] {
    var results = [HoshiTextField]()
    for subview in view.subviews as [UIView] {
        if let textField = subview as? HoshiTextField {
            results += [textField]
        } else {
            results += getTextfield(view: subview)
        }
    }
    return results
}
}
