//
//  AppointmentDetailsViewController.swift
//  Project
//
//  Created by Hari Haran on 03/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var consultedText: HoshiTextField!
    @IBOutlet weak var commentsText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }
    
}

//MARK: View Setups
extension AppointmentDetailsViewController {
    
    private func initialLoads() {
        setupNavigationBar()
        setTextFonts()
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
    
    
    @objc private func pushToThankYou(sender:UIButton) {
        sender.addPressAnimation()
        self.push(id: Storyboard.Ids.ThankYouViewController, animation: true)
        
    }
    
}


//MARK: Tabelview delegates and datasources
extension AppointmentDetailsViewController {
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 3:
            let footerView: UIView = {
                let footer = UIView()
                footer.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50)
                let submitBtn = UIButton()
                submitBtn.frame = CGRect(x: 15, y: 0, width: footer.frame.size.width - 30, height: footer.frame.size.height)
                submitBtn.backgroundColor = UIColor.lightBlue
                submitBtn.setTitle("Submit", for: .normal)
                submitBtn.addTarget(self, action: #selector(pushToThankYou(sender:)), for: .touchUpInside)
                Common.setFont(to: submitBtn)
                footer.addSubview(submitBtn)
                return footer
            }()
            return footerView
        default:
            return UIView()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 3 ? 50 : 0
    }
    
}
