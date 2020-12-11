//
//  AddMedicalRecordViewController.swift
//  MiDokter User
//
//  Created by Sethuram Vijayakumar on 01/12/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class AddMedicalRecordViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addMedicalRecordLabel: UILabel!
    @IBOutlet weak var descriptionLabe: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var instructionTextView: UITextView!
    @IBOutlet weak var doctorTexField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var isImageAdded : Bool = false
    
    private lazy var loader  : UIView = {
        return createActivityIndicator(self.view)
    }()
    
    var doctors = [Doctor]()
    var selectedDoctorId : Int = 0
    var selectedDoctorName : String = ""
    var selectedImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getDoctorList()
    }
    
}


extension AddMedicalRecordViewController {
    
    private func initalLoads(){
        self.setNavigation()
        self.localize()
        self.doctorTexField.delegate = self
        self.instructionTextView.delegate = self
        self.addImageView.isUserInteractionEnabled = true
//        let tap = UIGestureRecognizer(target: self, action: #selector(addImageAction))
        self.addImageView.addTap {
            self.showImage { (image) in
                self.addImageView.image = image
                self.isImageAdded = true
                self.selectedImage = image!
            }
        }
        
        self.submitButton.addTarget(self, action: #selector(submitAction(sender:)), for: .touchUpInside)
        self.backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
       
    }
    
    private func localize(){
        self.titleLabel.text = "Test Taken/Previous Prescription"
        self.addMedicalRecordLabel.text = "Add Image of the Medical Record"
        self.descriptionLabe.text = "Description/Instruction Given"
        self.doctorNameLabel.text = "Doctor Consulted"
        self.titleTextField.placeholder = "Test Taken/Previous Prescription"
        self.instructionTextView.text = "Instruction Given"
        self.instructionTextView.textColor = .lightGray
        self.doctorTexField.placeholder = "Doctor Name"
        self.submitButton.setTitle("Submit", for: .normal)
    }
    
    private func setNavigation(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction private func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getDoctorList(){
        self.presenter?.HITAPI(api: Base.getDoctor.rawValue, params: nil, methodType: .GET, modelClass: GetDoctors.self, token: true)
        self.loader.isHidden = false
    }
    
    
    
    @IBAction private func submitAction(sender:UIButton){
        guard let title = self.titleTextField.text , !title.isEmpty else {
            showToast(msg: "Enter Details")
            return
        }
        guard let description = self.instructionTextView.text , !description.isEmpty else {
            showToast(msg: "Enter Instruction/Description")
            return
        }
        if description == "Description/Instruction Given"{
            showToast(msg: "Enter Instruction/Description")
            return
        }
        
        guard  let doctorName = self.doctorTexField.text, !doctorName.isEmpty else {
            showToast(msg: "Enter Doctor Consulted")
            return
        }
        
        if !isImageAdded{
            showToast(msg: "Add Prescription Image")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:MM:SS"
        let dateString = dateFormatter.string(from: Date())
        
        var params = [String:Any]()
        params.updateValue(title, forKey: "title")
        params.updateValue(description, forKey:"instruction")
        params.updateValue(self.selectedDoctorId, forKey: "doctor_id")
        params.updateValue(UserDefaultConfig.PatientID, forKey: "patient_id")
        params.updateValue(dateString, forKey: "date")
        
        var imageData = [String:Data]()
        let imageValue = (self.addImageView.image?.pngRepresentationData)!
        imageData.updateValue(imageValue, forKey: "prescription_image")
        print(params)
        print(imageData)
        self.presenter?.IMAGEPOST(api: Base.addMedicalRecord.rawValue, params: params, methodType: .POST, imgData: imageData, imgName: "prescription_image", modelClass: AddMedicalRecordModel.self, token: true)
        self.loader.isHidden = false
        
    }
    
    
    
}


extension AddMedicalRecordViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.doctorTexField{
            var doctorsNames = [String]()
            doctorsNames = self.doctors.map({($0.first_name ?? "") + " " + ($0.last_name ?? "")})
            doctorsNames.append("Others")
            PickerManager.shared.showPicker(pickerData: doctorsNames, selectedData: textField.text, completionHandler: { (selectedValue) in
                textField.text = selectedValue
                for (index,value) in doctorsNames.enumerated(){
                    print(value)
                    if value == selectedValue{
                        self.selectedDoctorName = selectedValue
                        if self.selectedDoctorName == "Others"{
                            self.selectedDoctorId = 0
                        }else{
                        self.selectedDoctorId = self.doctors[index].id ?? 0
                        }
                        print(self.selectedDoctorId)
                    }
                }
                
            })
            
            
            return false
        }
        return true
    }
}


extension AddMedicalRecordViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Instruction Given"{
            textView.text = ""
            textView.textColor = .black
        }
    }
    
}


extension AddMedicalRecordViewController : PresenterOutputProtocol {
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
      
        DispatchQueue.main.async {
            switch String(describing: modelClass) {
         
                case model.type.GetDoctors:
                    self.loader.isHideInMainThread(true)
                    let data = dataDict as? GetDoctors
                    self.doctors = data?.doctor ?? []
                    break
                    
                case model.type.AddMedicalRecordModel:
                    self.loader.isHideInMainThread(true)
                    showToast(msg: "Medical Record Added Successfully")
                    let data = dataDict as? AddMedicalRecordModel
                    self.navigationController?.popViewController(animated: true)
                    break
                
                default: break
                
            }
            
        }
    }
    
    func showError(error: CustomError) {
        self.loader.isHideInMainThread(true)
        showToast(msg: error.localizedDescription)
    }
    
    
}
