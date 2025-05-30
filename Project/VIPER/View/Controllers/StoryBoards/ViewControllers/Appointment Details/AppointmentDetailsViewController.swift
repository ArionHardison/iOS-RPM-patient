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
    @IBOutlet weak var ratingView: FloatRatingView!
    
    var visitedDetail : Previous = Previous()
    var updatedVisitedDetail : Appointments = Appointments()
    var isFromVisited : Bool = false
    var likedStatus : String = ""
    var index : Int = 0
    var appoitmentID : Int = 0
    
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
        self.ratingView.minRating = 1
        self.ratingView.maxRating = 5
        self.ratingView.rating = 3
        self.ratingView.tintColor = UIColor.systemYellow
//        self.ratingView.tintColor = .AppBlueColor
//        self.ratingView.emptyImage = UIImage(systemName: "star")
//        self.ratingView.fullImage = UIImage(systemName: "star.fill")
    }
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Appointment Details"
    }
    
    private func setTextFonts() {
        
        Common.setFontWithType(to: doctorName, size: 18, type: .meduim)
        
        Common.setFontWithType(to: labelDesignation, size: 14, type: .regular)
        Common.setFontWithType(to: labelHospitalName, size: 12, type: .light)
        Common.setFontWithType(to: labelBookefor, size: 16, type: .meduim)
        Common.setFontWithType(to: labelPatientName, size: 14, type: .meduim)
        Common.setFontWithType(to: labelSchedule, size: 16, type: .meduim)
        Common.setFontWithType(to: labelDate, size: 14, type: .meduim)
        Common.setFontWithType(to: labelCategory, size: 10, type: .light)
        Common.setFontWithType(to: labelStatus, size: 16, type: .meduim)
        Common.setFontWithType(to: labelStatusResponse, size: 14, type: .meduim)
        Common.setFontWithType(to: labelShare, size: 14, type: .regular)
        Common.setFontWithType(to: likeButton, size: 18, type: .regular)
        Common.setFontWithType(to: dislikeButton, size: 18, type: .regular)
        Common.setFontWithType(to: consultedText, size: 16, type: .regular)
        Common.setFontWithType(to: commentsText, size: 16, type: .regular)
        Common.setFontWithType(to: SubmitButton, size: 16, type: .meduim)

//        self.likeButton.layer.cornerRadius = self.likeButton.frame.width / 2
//        self.dislikeButton.layer.cornerRadius = self.dislikeButton.frame.width / 2
//        self.likeButton.layer.borderColor = UIColor(named: "TextForegroundColor")?.cgColor
//        self.dislikeButton.layer.borderColor = UIColor(named: "TextForegroundColor")?.cgColor
//        self.likeButton.layer.borderWidth = 0.6
//        self.dislikeButton.layer.borderWidth = 0.6
    }
    
    
    func setupData(){
        if !isFromVisited{
//         let data : Visited_doctors = self.visitedDetail
          
            self.doctorImg.setURLImage(self.visitedDetail.appointments?[index].hospital?.doctor_profile?.profile_pic ?? "")
        self.doctorName.text = "\(self.visitedDetail.appointments?[index].hospital?.first_name ?? "") \(self.visitedDetail.appointments?[index].hospital?.last_name ?? "")".capitalized
        self.labelCategory.text = "\(self.visitedDetail.appointments?[index].hospital?.doctor_profile?.speciality?.name ?? "")".uppercased()
        self.labelHospitalName.text = "\(self.visitedDetail.appointments?[index].hospital?.clinic?.name ?? ""), \(self.visitedDetail.appointments?[index].hospital?.clinic?.address ?? "")".capitalized
            self.labelPatientName.text = "\(self.visitedDetail.first_name ?? "")  \(self.visitedDetail.last_name ?? "")"
            self.labelDate.text = dateConvertor(self.visitedDetail.appointments?[index].scheduled_at ?? "", _input: .date_time, _output: .DMY_Time)
            if self.visitedDetail.appointments?[index].status ?? "" == "CHECKEDOUT"{
                self.labelStatusResponse.text = "Consulted"
            }else{
            self.labelStatusResponse.text = self.visitedDetail.appointments?[index].status ?? ""
                self.appoitmentID = self.visitedDetail.appointments?[index].id ?? 0
            }
        }else{
            let data : Appointments = self.updatedVisitedDetail
            self.doctorImg.setURLImage(data.hospital?.doctor_profile?.profile_pic ?? "")
        self.doctorName.text = "\(data.hospital?.first_name ?? "") \(data.hospital?.last_name ?? "")".capitalized
        self.labelCategory.text = "\(data.hospital?.doctor_profile?.speciality?.name ?? "")".uppercased()
        self.labelHospitalName.text = "\(data.hospital?.clinic?.name ?? ""), \(data.hospital?.clinic?.address ?? "")".capitalized
        self.labelPatientName.text = "\(data.booking_for ?? "")"
        self.labelDate.text = dateConvertor(data.scheduled_at ?? "", _input: .date_time, _output: .DMY_Time)
        self.labelStatusResponse.text = data.status ?? ""
            self.appoitmentID = data.id ?? 0
        }
        
    }
    
    
    func setupAction(){
        
        let likeImg = UIImage(named: "Like-1")
        let disLikeImg = UIImage(named: "dislike-1")
        let normalLikeImg = UIImage(named: "like")
        let normalDisLikeImg = UIImage(named: "dislike")

        
        self.likeButton.addTap {
            self.likeButton.setImage(likeImg, for: .normal)
            self.dislikeButton.setImage(normalDisLikeImg, for: .normal)
//            self.likeButton.backgroundColor = UIColor.AppBlueColor
//            self.dislikeButton.backgroundColor = UIColor.clear
            self.likedStatus = "LIKE"
        }
        
        self.dislikeButton.addTap {
            
            self.likeButton.setImage(normalLikeImg, for: .normal)
            self.dislikeButton.setImage(disLikeImg, for: .normal)
//            self.likeButton.backgroundColor = UIColor.clear
//            self.dislikeButton.backgroundColor = UIColor.AppBlueColor
            self.likedStatus = "DISLIKE"
        }
        
        self.SubmitButton.addTap {
            if validation(){
                var comment = FeedBackReq()
                comment.comments = self.commentsText.text ?? ""
                comment.experiences = self.likedStatus
                comment.hospital_id = (self.visitedDetail.appointments?[self.index].hospital?.id ?? 0).description
                comment.visited_for = self.consultedText.getText
                comment.rating = "\(self.ratingView.rating)"
                comment.title = "Rating Review"
                comment.appointment_id = self.appoitmentID
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        if !isFromVisited{
            if self.visitedDetail.appointments?[index].patient_rating == 0{
                return 4
            }else{
                return 2
            }
        }else{
            if self.updatedVisitedDetail.patient_rating == 0{
                return 4
            }else{
                return 2
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
