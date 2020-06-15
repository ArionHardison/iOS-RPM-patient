//
//  ChatQuestionViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 13/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class ChatQuestionViewController: UIViewController {
    
    
    @IBOutlet weak var suggestionList : UITableView!
    @IBOutlet weak var chatwithDotTitleLbl : UILabel!
    @IBOutlet weak var chooseSpecialityLbl : UILabel!
    @IBOutlet weak var symptomsLbl : UILabel!
    @IBOutlet weak var symptomsTxt : UITextView!
    @IBOutlet weak var submitBtn : UIButton!
    
    var suggestiondata : [demoSuggestion] = [demoSuggestion]()
    var selectedindex : Int  = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initailSetup()
    }
    
    func demoData(){
        self.suggestiondata.append(demoSuggestion(title: "Pediatrics", original: "$ 20", offer: "$ 10"))
        self.suggestiondata.append(demoSuggestion(title: "General Physician", original: "$ 15", offer: "$ 18"))
        self.suggestiondata.append(demoSuggestion(title: "Ear, Nose, Throat", original: "$ 12", offer: "$ 10"))
        self.suggestiondata.append(demoSuggestion(title: "Pediatrics", original: "$ 20", offer: "$ 10"))
    }
    
    func initailSetup(){
        self.setupNavigation()
        self.setupAction()
        self.setupTableViewCell()
        self.setupFont()
    }
    
    func setupNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Chat"
    }
    
    func setupFont(){
        Common.setFont(to: self.chatwithDotTitleLbl, isTitle: true, size: 24)
        Common.setFont(to: self.chooseSpecialityLbl, isTitle: true, size: 18)
        Common.setFont(to: self.symptomsLbl, isTitle: false, size: 16)
        Common.setFont(to: self.symptomsTxt, isTitle: false, size: 17)
        Common.setFont(to: self.submitBtn, isTitle: true, size: 20)
    }
    
    func setupAction(){
        self.submitBtn.addTap {
            self.push(id: Storyboard.Ids.SummaryViewController, animation: true)
        }
    }

}

extension ChatQuestionViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.suggestiondata.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.SuggestedCell) as! SuggestedCell
        if indexPath.row == suggestiondata.count-1{
            cell.allSplistView.isHidden = false
        }else{
            cell.allSplistView.isHidden = true
        }
        
        if selectedindex == indexPath.row{
            cell.suggetionView.borderColor = UIColor.AppBlueColor
            cell.titleLbl.textColor = UIColor.AppBlueColor
            cell.offerPriceLbl.textColor = UIColor.AppBlueColor
            cell.priceLbl.textColor = UIColor.AppBlueColor
            cell.offerPriceView.backgroundColor = UIColor.AppBlueColor
            cell.suggetionView.setCorneredElevation(shadow: 1, corner: 10, color: UIColor.AppBlueColor)
        }else{
            
            cell.suggetionView.setCorneredElevation(shadow: 1, corner: 10, color: UIColor.gray)
            cell.suggetionView.borderColor = UIColor.black
            cell.titleLbl.textColor = UIColor.black
            cell.offerPriceLbl.textColor = UIColor.black
            cell.priceLbl.textColor = UIColor.black
            cell.offerPriceView.backgroundColor = UIColor.black
        }
        
        if let data : demoSuggestion = self.suggestiondata[indexPath.row]{
            cell.titleLbl.text = data.title
            cell.offerPriceLbl.text = data.original
            cell.priceLbl.text = data.offer
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == suggestiondata.count-1{
            self.present(id: Storyboard.Ids.SelectedProblemAreaVC, animation: true)
        }else{
            self.selectedindex = indexPath.row
            self.suggestionList.reloadData()
        }
    
    }
    
    func setupTableViewCell(){
        self.suggestionList.registerCell(withId: XIB.Names.SuggestedCell)
        self.demoData()
    }
    
}


struct demoSuggestion {
    var title : String
    var original : String
    var offer : String
    
}
