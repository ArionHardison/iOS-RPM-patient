//
//  ChatViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 13/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    
    @IBOutlet weak var chatListTable : UITableView!
    @IBOutlet weak var msgTxt : UITextField!
    @IBOutlet weak var docuploadView : UIView!
    @IBOutlet weak var imageuploadView : UIView!
    @IBOutlet weak var infoLbl : UILabel!
    
    let msg : [String] = ["asasdasdasd" , "asjdgha,sjgdv,jahsgvd" , "hihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihi" , "hihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihi" , "hih"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initailSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func initailSetup(){
        self.setupTableViewCell()
        self.setupNavigation()
        Common.setFont(to: self.infoLbl)
        Common.setFont(to: self.msgTxt)
    }
    
    func setupNavigation(){
        
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Search Doctors"
        
        self.docuploadView.makeRoundedCorner()
        self.imageuploadView.makeRoundedCorner()
    }
    

}


extension ChatMessageViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.msg.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ChatRightCell) as! ChatRightCell
        cell.msgLbl.text = self.msg[indexPath.row]
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
   
    
    func setupTableViewCell(){
        self.chatListTable.registerCell(withId: XIB.Names.ChatRightCell)
    }
    
}
