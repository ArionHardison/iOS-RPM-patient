//
//  ReminderViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 13/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class ReminderViewController: UIViewController {
    
    @IBOutlet weak var reminderList : UITableView!
    @IBOutlet weak var addreminderImg : UIImageView!
    @IBOutlet weak var addreminderLbl : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initailSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    func initailSetup(){
        self.setupTableViewCell()
        self.setupNavigation()
        self.setupAction()
        Common.setFont(to: self.addreminderLbl)
       
    }
    
    func setupAction(){
        self.addreminderImg.addTap{
             self.push(id: Storyboard.Ids.ReminderDetailViewController, animation: true)
        }
    }
    
    func setupNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Reminder"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
        
        let addBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").resizeImage(newWidth: 20), style: .plain, target: self, action: #selector(addReminderAction))
        self.navigationItem.rightBarButtonItems = [addBtn]
    }
    
    @objc func addReminderAction() {
        self.push(id: Storyboard.Ids.ReminderDetailViewController, animation: true)
    }
    
    
}

extension ReminderViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ReminderCell) as! ReminderCell
        self.SearchCellAction(cell: cell)
        return cell
        
    }
    
    func SearchCellAction(cell : ReminderCell){
        cell.contentView.addTap {
            self.push(id: Storyboard.Ids.ReminderDetailViewController, animation: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func setupTableViewCell(){
        self.reminderList.registerCell(withId: XIB.Names.ReminderCell)
    }
    
}
