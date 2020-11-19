//
//  UpcomingDetailsController.swift
//  Project
//
//  Created by Chan Basha on 23/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class UpcomingDetailsController: UITableViewController {
    
    
    @IBOutlet weak var doctorImg: UIImageView!
    
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var labelDesignation: UILabel!
    @IBOutlet weak var locationImg: UIImageView!
    @IBOutlet weak var labelHospitalName: UILabel!
    @IBOutlet weak var labelCategory: UILabel!

    @IBOutlet weak var labelBookefor: UILabel!
    
    
    @IBOutlet weak var labelPatientName: UILabel!
    
    @IBOutlet weak var labelSchedule: UILabel!
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelStatusType: UILabel!

    @IBOutlet weak var buttonCancel: UIButton!
//    @IBOutlet weak var videoCallButton: UIButton!
    
    var appointment = Appointments()
    var isFromUpcomming:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initalLoads()
        self.setTextFonts()
        
        
    }
    
    private func setTextFonts() {
        
        Common.setFontWithType(to: doctorName, size: 18, type: .meduim)
        Common.setFontWithType(to: labelDesignation, size: 10, type: .regular)
        Common.setFontWithType(to: labelHospitalName, size: 12, type: .light)
        Common.setFontWithType(to: labelBookefor, size: 16, type: .meduim)
        Common.setFontWithType(to: labelPatientName, size: 14, type: .meduim)
        Common.setFontWithType(to: labelSchedule, size: 16, type: .meduim)
        Common.setFontWithType(to: labelDate, size: 14, type: .meduim)
        Common.setFontWithType(to: buttonCancel, size: 14, type: .meduim)
        Common.setFontWithType(to: labelCategory, size: 14, type: .light)


//        Common.setFontWithType(to: labelStatus, size: 16, type: .meduim)
    }

   
}

extension UpcomingDetailsController {
    
    private func initalLoads(){
        
        self.doctorName.text = "\(self.appointment.hospital?.first_name ?? "") \(self.appointment.hospital?.last_name ?? "")".capitalized
        self.labelHospitalName.text = "\(self.appointment.hospital?.clinic?.name ?? ""), \(self.appointment.hospital?.clinic?.address ?? "")".capitalized
        self.labelDate.text = dateConvertor(self.appointment.scheduled_at ?? "", _input: .date_time, _output: .DMY_Time)
        self.labelPatientName.text = (self.appointment.hospital?.first_name ?? "").capitalized + (self.appointment.hospital?.last_name ?? "").capitalized
//        self.doctorName.text = self.appointment.hospital?.clinic?.name ?? "".capitalized
        self.labelDesignation.text = self.appointment.hospital?.doctor_profile?.speciality?.name ?? "".uppercased()
        self.doctorImg.setImage(with: self.appointment.hospital?.doctor_profile?.profile_pic, placeHolder: #imageLiteral(resourceName: "1"))
        self.buttonCancel.addTarget(self, action: #selector(cancelAppointment(sender:)), for: .touchUpInside)
//        self.videoCallButton.addTarget(self, action: #selector(videoCallAction(sender:)), for: .touchUpInside)
//        self.videoCallButton.isHidden = !isFromUpcomming
        self.buttonCancel.isHidden = isFromUpcomming
    }
    
    
    
   @IBAction func cancelAppointment(sender:UIButton){
    self.presenter?.HITAPI(api: Base.cancelAppointment.rawValue, params: ["id" : self.appointment.id ?? 0], methodType: .POST, modelClass: CommonModel.self, token: true)
    }
    
    
    @IBAction private func videoCallAction(sender:UIButton){
        if #available(iOS 13.0, *) {
         let twilioVideoController = self.storyboard?.instantiateViewController(identifier: "audioVideoCallCaontroller") as! audioVideoCallCaontroller
            twilioVideoController.modalPresentationStyle = .fullScreen
            self.present(twilioVideoController, animated: true, completion: {
                twilioVideoController.video = 1
                twilioVideoController.receiverId = "\(self.appointment.hospital?.id ?? 0 )"
                twilioVideoController.receiverName = (self.appointment.hospital?.clinic?.name ?? "")
                twilioVideoController.isCallType = .makeCall
                twilioVideoController.handleCall(roomId: "12345", receiverId: "\(self.appointment.hospital?.id  ?? 0 )",isVideo : 1)
                               })
                           } else {
                             // Fallback on earlier versions
                           }

        
    }
    
    
}



extension UpcomingDetailsController : PresenterOutputProtocol {
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
        case model.type.AppointmentModel:
            
           let data = dataDict as? AppointmentModel
           self.navigationController?.popViewController(animated: true)
            break
        default:
            break
        }
       
    }
    
    func showError(error: CustomError) {
        
    }
    
    
}
