//
//  OnlineAvailabeDoctorsController.swift
//  Project
//
//  Created by Chan Basha on 23/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class OnlineAvailabeDoctorsController: UIViewController {

    @IBOutlet weak var doctorsListTV: UITableView!
    
    var chatData : ChatHistoryEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       registerCell()
        setNav()
       
    }
    
   
    
    private func registerCell(){
        
       
        doctorsListTV.register(UINib(nibName: XIB.Names.OnlineDoctorCell, bundle: .main), forCellReuseIdentifier:  XIB.Names.OnlineDoctorCell)
        
    }
    
    func setNav() {
        self.navigationController?.isNavigationBarHidden = false
       self.navigationItem.title = "Online Consultants"
        Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.getChatHistory()
    }

}
extension OnlineAvailabeDoctorsController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.chatData?.chats?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.OnlineDoctorCell, for: indexPath) as! OnlineDoctorCell
        cell.selectionStyle = .none
        if let data = self.chatData?.chats?[indexPath.row]{
            cell.labelDocotrName.text = (data.hospital?.first_name ?? "") + " " + (data.hospital?.last_name ?? "")
            cell.labelSubtitle.text = (data.chat_request?.messages ?? "")
            cell.labelTiming.text = dateConvertor((data.chat_request?.started_at ?? ""), _input: .date_time, _output: .N_hour)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = self.chatData?.chats?[indexPath.row]{
            if data.chat_request?.status == "ACCEPTED"{
                ChatManager.shared.setChannelWithChannelID(channelID: "\(data.chennel ?? "0")")
                let vc = ChatViewController.initVC(storyBoardName: .main, vc: ChatViewController.self, viewConrollerID: Storyboard.Ids.ChatViewController)
                vc.chats = self.chatData?.chats?[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
//                self.navigationController?.pushViewController(vc, animated: true)
            }else if data.chat_request?.status == "COMPLETED"{
                showToast(msg: "activity!!, Chat time expired, Request again",bgcolor: .red)
            }else if data.chat_request?.status == "CANCELLED"{
                showToast(msg: "activity!!, Doctor not accepted your request",bgcolor: .red)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
  
}
//Api calls
extension OnlineAvailabeDoctorsController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.ChatHistoryEntity:
                guard let data = dataDict as? ChatHistoryEntity else { return }
                self.chatData = data
                self.doctorsListTV.reloadData()
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    
    func getChatHistory(){
        self.presenter?.HITAPI(api: Base.chatHistory.rawValue, params: nil, methodType: .GET, modelClass: ChatHistoryEntity.self, token: true)
    }
    
    
}
