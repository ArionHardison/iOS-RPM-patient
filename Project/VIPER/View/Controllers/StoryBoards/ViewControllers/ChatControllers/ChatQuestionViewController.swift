////
//  ChatQuestionViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 13/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class ChatQuestionViewController: UIViewController {
    
    
    @IBOutlet weak var suggestionList : UITableView!
    @IBOutlet weak var chatwithDotTitleLbl : UILabel!
    @IBOutlet weak var chooseSpecialityLbl : UILabel!
    @IBOutlet weak var symptomsLbl : UILabel!
    @IBOutlet weak var symptomsTxt : UITextView!
    @IBOutlet weak var submitBtn : UIButton!
    
    var category : [Category] = [Category]()
    var AllAategory : [Category] = [Category]()
    var selectedindex : Int  = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initailSetup()
    }
    
    
    func initailSetup(){
        self.setupNavigation()
        self.setupAction()
        self.setupTableViewCell()
        self.setupFont()
        self.getCatagoryList()
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
            let vc = SummaryViewController.initVC(storyBoardName: .main, vc: SummaryViewController.self, viewConrollerID: Storyboard.Ids.SummaryViewController)
            vc.selectedCategory = self.category[self.selectedindex]
            vc.message = self.symptomsTxt.text ?? ""
            self.push(from: self, ToViewContorller: vc)
        }
    }
    
}

extension ChatQuestionViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.category.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.SuggestedCell) as! SuggestedCell
        if indexPath.row ==  self.category.count{
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
        if indexPath.row <= self.category.count-1{
        if let data : Category = self.category[indexPath.row]{
            cell.titleLbl.text = data.name
            cell.offerPriceLbl.text = data.offer_fees
            cell.priceLbl.text = data.fees
        }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row ==  self.category.count{
            let vc = SelectedProblemAreaVC.initVC(storyBoardName: .main, vc: SelectedProblemAreaVC.self, viewConrollerID: Storyboard.Ids.SelectedProblemAreaVC)
            vc.category = self.AllAategory
            
            vc.selectedCategory = {(category) in
                self.category.remove(at: 2)
                self.selectedindex = 2
                self.category.append(category)
                
                self.suggestionList.reloadData()
            }
            
            self.present(vc: vc)
        }else{
            self.selectedindex = indexPath.row
            self.suggestionList.reloadData()
        }
   //     self.submitBtn.setCorneredElevation(shadow: <#T##Int#>, corner: <#T##Int#>, color: <#T##UIColor#>)
    }
    
    func setupTableViewCell(){
        self.suggestionList.registerCell(withId: XIB.Names.SuggestedCell)
        
    }
    
}


//Api calls
extension ChatQuestionViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.CategoryList:
                
                let data = dataDict as? CategoryList
                if data?.category?.count ?? 0 > 3{
                    self.category.append((data?.category?[0])!)
                    self.category.append((data?.category?[1])!)
                    self.category.append((data?.category?[2])!)
                }else{
                    self.category = data?.category ?? [Category]()
                }
                self.AllAategory = data?.category ?? [Category]()
                self.suggestionList.reloadData()
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getCatagoryList(){
        self.presenter?.HITAPI(api: Base.catagoryList.rawValue, params: nil, methodType: .GET, modelClass: CategoryList.self, token: true)
    }
    
    func cancelAppointment(id : String){
        self.presenter?.HITAPI(api: Base.cancelAppointment.rawValue, params: ["id" : id], methodType: .POST, modelClass: CommonModel.self, token: true)
    }
}




struct demoSuggestion {
    var title : String
    var original : String
    var offer : String
    
}
