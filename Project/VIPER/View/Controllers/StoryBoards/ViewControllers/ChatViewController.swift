//
//  ChatViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 13/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import ObjectMapper

class ChatViewController: UIViewController {

    
    @IBOutlet weak var chatListTable : UITableView!
    @IBOutlet weak var msgTxt : UITextField!
    @IBOutlet weak var docuploadView : UIView!
    
    @IBOutlet weak var imageuploadView : UIView!
    @IBOutlet weak var infoLbl : UILabel!
    @IBOutlet weak var messageSendBtn : UIButton!
    @IBOutlet var chatView: UIView!
    
    
    
    var messageDataSource:[MessageDetails]?
    var chats : Chats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChatManager.shared.getCurrentRoomChatHistory()
        ChatManager.shared.delegate = self
        self.initailSetup()
        IQKeyboardManager.shared.enable = false
        KeyboardManager.shared.keyBoardShowHide(view: self.chatView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ChatManager.shared.leftFromChatRoom()
        IQKeyboardManager.shared.enable = true
    }
    
    func initailSetup(){
        self.setupTableViewCell()
        self.setupNavigation()
        Common.setFont(to: self.infoLbl)
        Common.setFont(to: self.msgTxt)
        self.messageSend()
    }
    
    func setupNavigation(){
        
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Search Doctors"
        
        self.docuploadView.makeRoundedCorner()
        self.imageuploadView.makeRoundedCorner()
    }
    func messageSend(){
        self.messageSendBtn.addTap {
            if (self.msgTxt.text ?? "").isEmpty{
                showToast(msg: "Messge should not be empty")
            }else{
            ChatManager.shared.sentMessage(message: self.msgTxt.text ?? "", senderId: Int(UserDefaultConfig.PatientID ?? "0") ?? 0, timestamp: Date().description, provider_id: (self.chats?.hospital?.id ?? 0).description)
               
                let url = "\(Base.chatpush.rawValue)?message=\(self.msgTxt.getText)&doctor_id=\(self.chats?.hospital?.doctor_profile?.id ?? 0)"
                self.presenter?.HITAPI(api: url, params: nil, methodType: .GET, modelClass: CardSuccess.self, token: true)
                
//                ChatManager.shared.sentMessage(message: self.msgTxt.text ?? "", senderId: (self.chats?.hospital?.id ?? 0), timestamp: Date().description, provider_id: (UserDefaultConfig.PatientID).description)
//                ChatManager.shared.sendFile(with: <#T##PNSendFileRequest#>, completion: <#T##PNSendFileCompletionBlock?##PNSendFileCompletionBlock?##(PNSendFileStatus) -> Void#>)
               
            }
        }
        
    }

}
//MARK:- Message Manager Delegates
extension ChatViewController:ChatProtocol {
    
    func getMessageList(message: [MessageDetails]) {
        print("ChatMsgList",message)
        self.messageDataSource = message
        chatListTable.reloadInMainThread()
        if message.count > 0{
        self.scrollToBottom()
        }
         self.msgTxt.text = ""
    }
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: (self.messageDataSource?.count ?? 0)-1, section: 0)
            self.chatListTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension ChatViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let data : MessageDetails = self.messageDataSource?[indexPath.row]{
            
            if data.senderId == UserDefaultConfig.PatientID{
                let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ChatRightCell) as! ChatRightCell
                cell.msgLbl.text = self.messageDataSource?[indexPath.row].message ?? ""
                cell.timeLbl.text = dateConvertor(self.messageDataSource?[indexPath.row].time ?? "", _input: .date_time_Z, _output: .N_hour)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ChatLeftCell) as! ChatLeftCell
                cell.msgLbl.text = self.messageDataSource?[indexPath.row].message ?? ""
                cell.timeLbl.text = dateConvertor(self.messageDataSource?[indexPath.row].time ?? "", _input: .date_time_Z, _output: .N_hour)
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ChatLeftCell) as! ChatLeftCell
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
   
    
    func setupTableViewCell(){
        self.chatListTable.registerCell(withId: XIB.Names.ChatRightCell)
        self.chatListTable.registerCell(withId: XIB.Names.ChatLeftCell)
    }
    
}


extension ChatViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
                
    }
    
    func showError(error: CustomError) {
        
    }
    
    
}
