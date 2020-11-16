//
//  AppointmentViewController.swift
//  Project
//
//  Created by Chan Basha on 15/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class AppointmentViewController: UIViewController {

    
       @IBOutlet var pastBtn: UIButton!
       @IBOutlet var upCommingBtn: UIButton!
       @IBOutlet private var underLineView: UIView!
       @IBOutlet private var tableViewList : UITableView!
       
       var isYourTripsSelected = true
    
      var upcomingAppointment : [Appointments] = [Appointments]()
      var previousAppointment : [Appointments] = [Appointments]()

    
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
        self.getAppointment()
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
               self.tableViewList.reloadInMainThread()
           }
       }
    
}

extension AppointmentViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFirstBlockSelected{
            return self.upcomingAppointment.count ?? 0
        }else {
            return self.previousAppointment.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.UpcomingTableviewCell, for: indexPath) as! UpcomingTableviewCell
        if isFirstBlockSelected{
            self.populateData(cell: cell, data: self.upcomingAppointment[indexPath.row])
        }else {
            self.populateData(cell: cell, data: self.previousAppointment[indexPath.row])
        }
        
        return cell
        
    }
 
    func populateData(cell : UpcomingTableviewCell , data : Appointments){
        cell.labelDate.text = dateConvertor(data.scheduled_at ?? "", _input: .date_time, _output: .DM)
        cell.labelTime.text = dateConvertor(data.scheduled_at ?? "", _input: .date_time, _output: .N_hour)
        cell.labeldoctorName.text = "Dr.\(data.hospital?.first_name ?? "") \(data.hospital?.last_name ?? "")"
        cell.labelSubtitle.text = "\(data.hospital?.email ?? "")"
        cell.selectionStyle = .none
        cell.buttonCancel.isHidden = !isFirstBlockSelected
        cell.labelStatus.isHidden = isFirstBlockSelected
        cell.statusWidth.constant = isFirstBlockSelected ? 0 : 81
        cell.labelStatus.layer.cornerRadius = 4
        cell.labelStatus.text = data.status ?? ""
        if data.status ?? "" == "CANCELLED"{
            cell.labelStatus.backgroundColor = UIColor.red.withAlphaComponent(0.2)
            cell.labelStatus.textColor = UIColor.red
        }else{
            cell.labelStatus.backgroundColor = UIColor.LightGreen
            cell.labelStatus.textColor = UIColor.AppBlueColor
        }
        
        cell.buttonCancel.addTap {
            self.cancelAppointment(id: data.id?.description ?? "")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.UpcomingDetailsController) as! UpcomingDetailsController
          
    //            vc.buttonCancel.isHidden = false
                vc.appointment = self.upcomingAppointment[indexPath.row]
            vc.isFromUpcomming = self.isFirstBlockSelected
            self.navigationController?.pushViewController(vc, animated: true)
        }
    
            
    
//        self.push(id: Storyboard.Ids.UpcomingDetailsController, animation: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}




//Api calls
extension AppointmentViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.AppointmentModel:
                
               let data = dataDict as? AppointmentModel
               self.upcomingAppointment = data?.upcomming?.appointments ?? [Appointments]()
               self.previousAppointment = data?.previous?.appointments ?? [Appointments]()
               self.reloadTable()
                break
            case model.type.CommonModel:
                if let data = dataDict as? CommonModel{
                    if data.status ?? false{
                        self.getAppointment()
                    }
                }
            break
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getAppointment(){
        self.presenter?.HITAPI(api: Base.appointment.rawValue, params: nil, methodType: .GET, modelClass: AppointmentModel.self, token: true)
    }
    
    func cancelAppointment(id : String){
        self.presenter?.HITAPI(api: Base.cancelAppointment.rawValue, params: ["id" : id], methodType: .POST, modelClass: CommonModel.self, token: true)
    }
}
