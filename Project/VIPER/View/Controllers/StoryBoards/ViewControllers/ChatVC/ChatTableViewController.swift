//
//  ChatTableViewController.swift
//  Project
//
//  Created by Hari Haran on 04/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class ChatTableViewController: UITableViewController {

    
    let titleArray = ["Pediatrics","General Physician","Ear,Nose,Throat","See all specialities >"]
    let valueArray = ["$10","$15","$20",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }

   

}


//MARK: View Setups
extension ChatTableViewController {
    
    private func initialLoads() {
        setupNavigationBar()
        //setTextFonts()
        registerCell()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Chat"
    }
    
    private func registerCell() {
        self.tableView.register(UINib(nibName: XIB.Names.SuggestedSpecialityCell, bundle: nil), forCellReuseIdentifier: XIB.Names.SuggestedSpecialityCell)
        self.tableView.register(UINib(nibName: XIB.Names.ChatCommentCell, bundle: nil), forCellReuseIdentifier: XIB.Names.ChatCommentCell)
        
    }
    
    /*
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
    */
    
    
    @objc private func pushToThankYou(sender:UIButton) {
        sender.addPressAnimation()
        self.push(id: Storyboard.Ids.ThankYouViewController, animation: true)
        
    }
    
    
}


//MARK: Tabelview delegates and datasources
extension ChatTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : titleArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ChatCommentCell) as? ChatCommentCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.SuggestedSpecialityCell) as? SuggestedSpecialityCell else {
                return UITableViewCell()
            }
            cell.valueLabel.isHidden = indexPath.row == 3 ? true : false
            cell.titleLabel.text = titleArray[indexPath.row]
            cell.valueLabel.text = valueArray[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = {
            
            let header = UIView()
            header.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50)
            let titleLabel = UILabel()
            titleLabel.frame = CGRect(x: 15, y: 0, width: header.frame.size.width - 30, height: header.frame.size.height)
            titleLabel.text = section == 0 ? "Chat with a doctor" : "Choose a suggested speciality"
            Common.setFont(to: titleLabel, isTitle: section == 0 ? true : false, size: 0)
            header.addSubview(titleLabel)
            return header
        }()
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let footerView: UIView = {
                
                let footer = UIView()
                footer.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50)
                let submitBtn = UIButton()
                submitBtn.frame = CGRect(x: 15, y: 0, width: footer.frame.size.width - 30, height: footer.frame.size.height)
                submitBtn.layer.cornerRadius = 3
                submitBtn.backgroundColor = UIColor.lightBlue
                submitBtn.setTitle("Submit", for: .normal)
               // submitBtn.addTarget(self, action: #selector(pushToThankYou(sender:)), for: .touchUpInside)
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
        return section == 1 ? 50 : 0
    }
    
}
