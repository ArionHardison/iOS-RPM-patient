//
//  ReminderViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 13/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class ReminderViewController: UIViewController {
    
    @IBOutlet weak var reminderList : UITableView!
    @IBOutlet weak var addreminderImg : UIImageView!
    @IBOutlet weak var addreminderLbl : UILabel!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var noDataLabel: UILabel!

    var remainder : [Reminder]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.initailSetup()
    }
    
    
    func initailSetup(){
        self.setupTableViewCell()
        self.setupNavigation()
        self.setupAction()
        Common.setFont(to: self.addreminderLbl)
        self.reminderList.isHidden = false
        self.noDataView.isHidden = true
        self.noDataLabel.text = "No Remainders"
        self.presenter?.HITAPI(api: Base.remainderApi.rawValue, params: nil, methodType: .GET, modelClass: Remainder.self, token: true)
        self.addreminderImg.image =  self.addreminderImg.image?.withRenderingMode(.alwaysTemplate)
        self.addreminderImg.tintColor = .AppBlueColor
       
    }
    
    func setupAction(){
        self.addreminderImg.addTap{
                   let reminderVc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.ReminderDetailViewController) as! ReminderDetailViewController
               reminderVc.isNewReminder = true
               self.navigationController?.pushViewController(reminderVc, animated: true)
        }
    }
    
    func setupNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Remainder"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
    }
    
    @objc func addReminderAction() {
            let reminderVc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.ReminderDetailViewController) as! ReminderDetailViewController
        reminderVc.isNewReminder = true
        self.navigationController?.pushViewController(reminderVc, animated: true)
    }
    
    
}

extension ReminderViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remainder?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ReminderCell) as! ReminderCell
        cell.labelTiming.text = self.remainder?[indexPath.row].date
        cell.labelFirstChar.text = self.remainder?[indexPath.row].name?.substring(toIndex: 1)
        cell.labelReason.text = self.remainder?[indexPath.row].name
        
//        self.SearchCellAction(cell: cell)
        return cell
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reminderVc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.ReminderDetailViewController) as! ReminderDetailViewController
        reminderVc.remainder = self.remainder?[indexPath.row]
        reminderVc.isNewReminder = false
        self.navigationController?.pushViewController(reminderVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func setupTableViewCell(){
        self.reminderList.registerCell(withId: XIB.Names.ReminderCell)
    }
    
}


extension ReminderViewController : PresenterOutputProtocol {
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.Remainder:
                guard let data = dataDict as? Remainder else {return}
                self.remainder = data.reminder ?? []
                if self.remainder?.count ?? 0 > 0{
                    self.reminderList.isHidden = false
                    self.noDataView.isHidden = true
                }else{
                    self.reminderList.isHidden = true
                    self.noDataView.isHidden = false
                }
                self.reminderList.reloadInMainThread()
             break
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        showToast(msg: error.localizedDescription)
    }
    
    
}


extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
