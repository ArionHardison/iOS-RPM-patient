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
    
      var upcomingAppointment = Upcomming()
      var previousAppointment = Previous()

    
       private var isFirstBlockSelected = true {
           didSet {
               UIView.animate(withDuration: 0.5) {
                   self.underLineView.frame.origin.x = self.isFirstBlockSelected ? 0 : (self.view.bounds.width/2)
                self.underLineView.backgroundColor = UIColor(named: "AppBlueColor")
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
        Common.setFontWithType(to: self.navigationItem.title!, size: 18, type: .regular)
        Common.setFontWithType(to: self.upCommingBtn, size: 18, type: .regular)
        Common.setFontWithType(to: self.pastBtn, size: 18, type: .regular)

//        Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
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
            return self.upcomingAppointment.appointments?.count ?? 0
        }else {
            return self.previousAppointment.appointments?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.UpcomingTableviewCell, for: indexPath) as! UpcomingTableviewCell
        if isFirstBlockSelected{
            self.populateData(cell: cell, data: self.upcomingAppointment.appointments?[indexPath.row] ?? Appointments(),index: indexPath.row)
        }else {
            self.populateData(cell: cell, data: self.previousAppointment.appointments?[indexPath.row] ?? Appointments(),index: indexPath.row)
        }
        
        
        return cell
        
    }
 
    func populateData(cell : UpcomingTableviewCell , data : Appointments,index:Int){
        cell.labelDate.text = dateConvertor(data.scheduled_at ?? "", _input: .date_time, _output: .DM)
        cell.labelTime.text = dateConvertor(data.scheduled_at ?? "", _input: .date_time, _output: .N_hour)
        cell.labeldoctorName.text = "Dr.\(data.hospital?.first_name ?? "") \(data.hospital?.last_name ?? "")"
        cell.labelSubtitle.text = "\(data.hospital?.clinic?.name ?? ""),\(data.hospital?.clinic?.address ?? "")"  //"\(data.hospital?.email ?? "")"
        cell.selectionStyle = .none
        cell.makeVideoCallButton.tag = index
        cell.makeVideoCallButton.addTarget(self, action: #selector(callAction(sender:)), for: .touchUpInside)
        let value = isFirstBlockSelected ? 1 : 0
        cell.buttonCancel.isHidden = value == 1 ? false : true
        cell.labelStatus.isHidden = value == 0 ? false : true
//        cell.statusWidth.constant = isFirstBlockSelected ? 0 : 81
//        cell.labelStatus.layer.cornerRadius = 4
        if data.status ?? "" == "CANCELLED"{
            cell.labelStatus.backgroundColor = UIColor(named: "CustomRedColor") //UIColor.red.withAlphaComponent(0.2)
            cell.labelStatus.textColor = UIColor.red.withAlphaComponent(0.8) //UIColor(named: "")
        }else{
            cell.labelStatus.backgroundColor = UIColor(named: "LightGreen") //UIColor.LightGreen
            cell.labelStatus.textColor = UIColor(named: "ConfirmedGreenColor") //UIColor.AppBlueColor
        }
        cell.labelStatus.text = data.status ?? "".uppercased()

        cell.buttonCancel.addTap {
            self.cancelAppointment(id: data.id?.description ?? "")
        }
    }
    
    @IBAction private func callAction(sender:UIButton){
        if #available(iOS 13.0, *) {
         let twilioVideoController = self.storyboard?.instantiateViewController(identifier: "audioVideoCallCaontroller") as! audioVideoCallCaontroller
            twilioVideoController.modalPresentationStyle = .fullScreen
            self.present(twilioVideoController, animated: true, completion: {
                twilioVideoController.video = 1
                twilioVideoController.senderId = "\(self.previousAppointment.appointments?[sender.tag].doctor_id ?? 0 )"
                twilioVideoController.receiverName = (self.previousAppointment.appointments?[sender.tag].hospital?.first_name ?? "") + (self.previousAppointment.appointments?[sender.tag].hospital?.first_name ?? "")
                twilioVideoController.isCallType = .makeCall
                twilioVideoController.handleCall(roomId: "12345", receiverId: "\(self.previousAppointment.appointments?[sender.tag].doctor_id ?? 0)",isVideo : 1)
                               })
                           } else {
                             // Fallback on earlier versions
                           }

        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            
            if self.isFirstBlockSelected{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.UpcomingDetailsController) as! UpcomingDetailsController
                vc.appointment = self.upcomingAppointment //self.upcomingAppointment[indexPath.row]
                vc.index = indexPath.row
                vc.isFromUpcomming = true
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.AppointmentDetailsViewController) as! AppointmentDetailsViewController
                vc.visitedDetail = self.previousAppointment
                vc.index = indexPath.row
//                vc.visitedDetail = Visited_doctors(JSON: self.previousAppointment.appointments?[indexPath.row].toJSON() ?? Appointments().toJSON())!
                self.navigationController?.pushViewController(vc, animated: true)
            }
            

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
                self.upcomingAppointment = (data?.upcomming)!
               self.previousAppointment = (data?.previous)!
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
