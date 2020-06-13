//
//  AppointmentViewController.swift
//  Project
//
//  Created by Chan Basha on 15/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class AppointmentViewController: UIViewController {

    
       @IBOutlet var pastBtn: UIButton!
       @IBOutlet var upCommingBtn: UIButton!
       @IBOutlet private var underLineView: UIView!
       @IBOutlet private var tableViewList : UITableView!
       
       var isYourTripsSelected = true // Boolean Handle Passbook and Yourtrips list
       private var isFirstBlockSelected = true {
           didSet {
               UIView.animate(withDuration: 0.5) {
                   self.underLineView.frame.origin.x = self.isFirstBlockSelected ? 0 : (self.view.bounds.width/2)
                   self.underLineView.backgroundColor = .primary
               }
           }
       }
    
    lazy var loader  : UIView = {
           return createActivityIndicator(UIApplication.shared.keyWindow ?? self.view)
       }()
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoads()
    }
    
    
    
    private func initialLoads(){
        switchViewAction()
        tableViewList.register(UINib(nibName: XIB.Names.UpcomingTableviewCell, bundle: .main), forCellReuseIdentifier: XIB.Names.UpcomingTableviewCell)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Appointments"
        Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
   

   private func switchViewAction(){
         // self.pastUnderLineView.isHidden = false
          self.isFirstBlockSelected = true
          self.pastBtn.tag = 2
          self.upCommingBtn.tag = 1
          self.pastBtn.addTarget(self, action: #selector(ButtonTapped(sender:)), for: .touchUpInside)
          self.upCommingBtn.addTarget(self, action: #selector(ButtonTapped(sender:)), for: .touchUpInside)
      }
      
      @IBAction func ButtonTapped(sender: UIButton){
          
          self.isFirstBlockSelected = sender.tag == 1
          self.reloadTable()
      }
    
    
    private func reloadTable() {
           DispatchQueue.main.async {
               self.loader.isHidden = true
               //self.checkEmptyView()
               self.tableViewList.reloadData()
           }
       }
    
}

extension AppointmentViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.UpcomingTableviewCell, for: indexPath) as! UpcomingTableviewCell
        
        cell.labelDate.text = "28 Oct"
        cell.labelTime.text = "Sun 7:30 pm"
        cell.labeldoctorName.text = "Dr.Stephanie"
        cell.labelSubtitle.text = "Miot Hopital"
        cell.selectionStyle = .none
        cell.buttonCancel.isHidden = !isFirstBlockSelected
        cell.labelStatus.isHidden = isFirstBlockSelected
        cell.statusWidth.constant = isFirstBlockSelected ? 0 : 81
        cell.labelStatus.layer.cornerRadius = 4
        cell.labelStatus.text = "Consulted"
     
        return cell
        
    }
 
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(id: Storyboard.Ids.UpcomingDetailsController, animation: true)
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}
