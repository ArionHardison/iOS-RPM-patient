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
        self.symptomsTxt.delegate = self
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
//        Common.setFont(to: self.chatwithDotTitleLbl, isTitle: true, size: 24)
//        Common.setFont(to: self.chooseSpecialityLbl, isTitle: true, size: 18)
//        Common.setFont(to: self.symptomsLbl, isTitle: false, size: 16)
//        Common.setFont(to: self.symptomsTxt, isTitle: false, size: 17)
//        Common.setFont(to: self.submitBtn, isTitle: true, size: 20)
    }
    
    func setupAction(){
        self.submitBtn.addTap {
            let vc = SummaryViewController.initVC(storyBoardName: .main, vc: SummaryViewController.self, viewConrollerID: Storyboard.Ids.SummaryViewController)
            vc.selectedCategory = self.category[self.selectedindex]
            vc.offerPrice = self.category[self.selectedindex].offer_fees ?? ""
            vc.price = "\(self.category[self.selectedindex].fees ?? 0)"
            vc.message = self.symptomsTxt.text ?? ""
            self.push(from: self, ToViewContorller: vc)
        }
    }
    
}

extension ChatQuestionViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  (self.category.count ?? 0) + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.SuggestedCell) as! SuggestedCell
        if indexPath.row ==  self.category.count ?? 0{
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
            cell.allSplistView.setCorneredElevation(shadow: 0, corner: 10, color: UIColor(named: "GreyTextcolor")!)

        }else{
            
            cell.suggetionView.setCorneredElevation(shadow: 1, corner: 10, color: UIColor(named: "GreyTextcolor")!)
            cell.allSplistView.setCorneredElevation(shadow: 0, corner: 10, color: UIColor(named: "GreyTextcolor")!)

            cell.suggetionView.borderColor = UIColor(named: "GreyTextcolor")! //UIColor.black
            cell.titleLbl.textColor = UIColor(named: "GreyTextcolor")!//UIColor.black
            cell.offerPriceLbl.textColor = UIColor(named: "GreyTextcolor")! //UIColor.black
            cell.priceLbl.textColor = UIColor(named: "GreyTextcolor")! //UIColor.black
            cell.offerPriceView.backgroundColor = UIColor(named: "GreyTextcolor")! //UIColor.black
        }
        if indexPath.row <= (self.category.count )-1{
            let data : Category = self.category[indexPath.row]
            cell.titleLbl.text = data.name ?? ""
            cell.offerPriceLbl.text = "$ \(data.fees ?? 0)" 
            cell.priceLbl.text =  "$" + " " + (data.offer_fees ?? "")
        }
        
        return cell
            }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row ==  self.category.count {
            let vc = SelectedProblemAreaVC.initVC(storyBoardName: .main, vc: SelectedProblemAreaVC.self, viewConrollerID: Storyboard.Ids.SelectedProblemAreaVC)
            vc.category = self.AllAategory
            
            vc.selectedCategory = {(category,index) in
              
                if index >= 2{
                    self.category.remove(at: 2)
                    self.selectedindex = 2
                    self.category.append(category)
                }else{
//                    self.category.remove(at: index)
                    self.selectedindex = index
                    
                }
               
                
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
                if (data?.category?.count ?? 0) > 3{
                    self.category.append((data?.category?[0]) ?? Category())
                    self.category.append((data?.category?[1]) ?? Category())
                    self.category.append((data?.category?[2]) ?? Category())
                }else{
                    self.category = data?.category ?? [Category]()
                }
                self.AllAategory = data?.category ?? [Category]()
                self.suggestionList.reloadInMainThread()
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




extension ChatQuestionViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
}


struct demoSuggestion {
    var title : String
    var original : String
    var offer : String
    
}
