//
//  AppointmentDetailsViewController.swift
//  Project
//
//  Created by Hari Haran on 03/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class AppointmentDetailsViewController: UITableViewController {
    
    @IBOutlet weak var doctorImg: UIImageView!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var labelDesignation: UILabel!
    @IBOutlet weak var locationImg: UIImageView!
    @IBOutlet weak var labelHospitalName: UILabel!
    @IBOutlet weak var labelBookefor: UILabel!
    @IBOutlet weak var labelPatientName: UILabel!
    @IBOutlet weak var labelSchedule: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelStatusResponse: UILabel!
    @IBOutlet weak var labelShare: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var consultedText: HoshiTextField!
    @IBOutlet weak var commentsText: UITextView!
    
    var visitedDetail : Visited_doctors?
    var likedStatus : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setupData()
    }
    
}

//MARK: View Setups
extension AppointmentDetailsViewController {
    
    private func initialLoads() {
        setupNavigationBar()
        setTextFonts()
        self.doctorImg.makeRoundedCorner()
        self.setupAction()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Appointment Details"
    }
    
    private func setTextFonts() {
        Common.setFont(to: doctorName,isTitle: true,size: 22)
        Common.setFont(to: labelDesignation,isTitle: false,size: 16)
        Common.setFont(to: labelHospitalName,isTitle: false,size: 16)
        Common.setFont(to: labelBookefor,isTitle: false,size: 18)
        Common.setFont(to: labelPatientName,isTitle: true,size: 18)
        Common.setFont(to: labelSchedule,isTitle: false,size: 18)
        Common.setFont(to: labelDate,isTitle: true,size: 18)
        Common.setFont(to: labelCategory,isTitle: false,size: 16)
        Common.setFont(to: labelStatus,isTitle: true,size: 18)
        Common.setFont(to: labelStatusResponse,isTitle: false,size: 18)
        Common.setFont(to: labelShare,isTitle: false,size: 20)
        Common.setFont(to: likeButton,isTitle: true,size: 18)
        Common.setFont(to: dislikeButton,isTitle: true,size: 18)
        Common.setFont(to: consultedText,isTitle: true,size: 18)
        Common.setFont(to: commentsText,isTitle: true,size: 18)
        
        self.likeButton.layer.cornerRadius = self.likeButton.frame.width / 2
        self.dislikeButton.layer.cornerRadius = self.dislikeButton.frame.width / 2
        self.likeButton.layer.borderColor = UIColor.appColor.cgColor
        self.dislikeButton.layer.borderColor = UIColor.appColor.cgColor
        self.likeButton.layer.borderWidth = 1
        self.dislikeButton.layer.borderWidth = 1
    }
    
    
    func setupData(){
        if let data : Visited_doctors = self.visitedDetail{
          
            self.doctorImg.setURLImage(data.hospital?.doctor_profile?.profile_pic ?? "")
            self.doctorName.text = "\(data.hospital?.first_name ?? "") \(data.hospital?.last_name ?? "")"
            self.labelCategory.text = "\(data.hospital?.doctor_profile?.speciality?.name ?? "")"
            self.labelHospitalName.text = "\(data.hospital?.clinic?.name ?? ""), \(data.hospital?.clinic?.address ?? "")"
            self.labelPatientName.text = "\(data.booking_for ?? "")"
            self.labelDate.text = dateConvertor(data.scheduled_at ?? "", _input: .date_time, _output: .DMY_Time)
            self.labelStatusResponse.text = data.status ?? ""
        }
    }
    
    
    func setupAction(){
        self.likeButton.addTap {
            self.likeButton.backgroundColor = UIColor.AppBlueColor
            self.dislikeButton.backgroundColor = UIColor.clear
            self.likedStatus = "LIKE"
        }
        
        self.dislikeButton.addTap {
            self.likeButton.backgroundColor = UIColor.clear
            self.dislikeButton.backgroundColor = UIColor.AppBlueColor
            self.likedStatus = "DISLIKE"
        }
        
        self.SubmitButton.addTap {
            if validation(){
                var comment = FeedBackReq()
                comment.comments = self.commentsText.text ?? ""
                comment.experiences = self.likedStatus
                comment.hospital_id = (self.visitedDetail?.hospital?.id ?? 0).description
                comment.visited_for = self.consultedText.getText
                self.postFeedBack(feedback: comment)
            }
        }
        
        func validation() -> Bool{
            if self.consultedText.getText.isEmpty{
                showToast(msg: "Enter consultant detail")
                return false
            }else if (self.commentsText.text ?? "").isEmpty{
                showToast(msg: "Please Enter Your Comments")
                return false
            }else if self.likedStatus.isEmpty{
                showToast(msg: "Please Select Like or DisLike option")
                return false
            }else{
                return true
            }
        }
        
    }
   
    
}

//Api calls
extension AppointmentDetailsViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.FeedBackModel:
                let data = dataDict as? FeedBackModel
                showToast(msg: data?.message ?? "")
                self.push(id: Storyboard.Ids.ThankYouViewController, animation: true)
                break
            
            default:
                break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func postFeedBack(feedback : FeedBackReq){
        self.presenter?.HITAPI(api: Base.feedback.rawValue, params: convertToDictionary(model: feedback), methodType: .POST, modelClass: FeedBackModel.self, token: true)
    }
    
    
}
