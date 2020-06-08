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
        
        // Do any additional setup after loading the view.
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
        self.navigationItem.title = "Visited Doctors"
    }
    
    private func setTextFonts() {
        Common.setFont(to: doctorName)
        Common.setFont(to: labelDesignation)
        Common.setFont(to: labelHospitalName)
        Common.setFont(to: labelBookefor)
        Common.setFont(to: labelPatientName)
        Common.setFont(to: labelSchedule)
        Common.setFont(to: labelDate)
        Common.setFont(to: labelCategory)
        Common.setFont(to: labelStatus)
        Common.setFont(to: labelStatusResponse)
        Common.setFont(to: labelShare)
        Common.setFont(to: likeButton)
        Common.setFont(to: dislikeButton)
        Common.setFont(to: consultedText)
        Common.setFont(to: commentsText)
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
