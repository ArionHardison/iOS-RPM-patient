//
//  FilterViewController.swift
//  MiDokter User
//
//  Created by Basha's MacBook Pro on 19/11/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var fileterTableView: UITableView!
    @IBOutlet weak var applyView: UIView!
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var cancelButton : UIButton!
    var arr = ["","",""]
    var selectedAvailablity = String()
    var selectedPrice = String()
    var selectedGender :String = ""
    var orderCheckedStatus = [Int : [[Int] : Bool]]() // To update carton

    
    var hiddenSections = Set<Int>()
    var selectedData : [valueData]?
    var onClickDone : ((String,String,String)->Void)?
//    var dataSource : [Int:[[Int:Bool]]]?
    
    var selectedIndex : IndexPath?
//    var section = 0

    var sectionHeader = ["Availabilty","Gender","Consultation Fee"]
    var availabitlityArr = ["Available anyday","Available today","Available next 3 days","Available coming weekend"]
    var genderArr = ["MALE","FEMALE"]
    var consultationArr = ["1-20","20-30","30+"]
    
    private var dataCells = [Int : [Int : (row : Int?, isSelect : Bool)]]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpnavigation()
//        self.fileterTableView.allowsMultipleSelection = true
        
        self.fileterTableView.register(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: "FilterCell")
        self.applyButton.setTitle(Constants.string.apply.localize(), for: .normal)
        self.cancelButton.setTitle(Constants.string.Cancel.localize(), for: .normal)
        self.applyButton.addTarget(self, action: #selector(applyAction(sender:)), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(cancelAction(sender:)), for: .touchUpInside)
        self.initializeArr()


//        Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)

        // Do any additional setup after loading the view.
    }
    
    private func initializeArr(){
        
        selectedData = [valueData]()
        var rowss = [rRow]()
        
        for (index,val) in availabitlityArr.enumerated(){
           
            rowss.append(rRow(valueName: val, row: index, isSelected: false))
        }
        selectedData?.append(valueData(sectionName: sectionHeader[0], row: rowss))
        rowss.removeAll()
        for (index,val) in genderArr.enumerated(){
            rowss.append(rRow(valueName: val, row: index, isSelected: false))
        }
        selectedData?.append(valueData(sectionName: sectionHeader[1], row: rowss))
        rowss.removeAll()

        for (index,val) in consultationArr.enumerated(){
            rowss.append(rRow(valueName: val, row: index, isSelected: false))
        }
        selectedData?.append(valueData(sectionName: sectionHeader[2], row: rowss))
        rowss.removeAll()

        
    }
    
    
    func setUpnavigation() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
        self.navigationItem.title = "Filter"

        Common.setFontWithType(to: self.navigationItem.title!, size: 18, type: .regular)
        Common.setFontWithType(to: self.applyButton, size: 14, type: .meduim)
        Common.setFontWithType(to: self.cancelButton, size: 14, type: .meduim)

    }


}
extension FilterViewController {
    
    @IBAction private func cancelAction(sender:UIButton){
        
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func applyAction(sender:UIButton){
        print(self.selectedAvailablity)
        print(self.selectedGender)
        print(self.selectedPrice)
        var availability_type = String()
        var seleGender = String()
        var price = String()
        if selectedAvailablity == "Available anyday"{
            availability_type = "AvailableAllDAY"
            
        }else if selectedAvailablity == "Available today" {
            availability_type = "today"
            
        }else if selectedAvailablity == "Available next 3 days" {
            availability_type = "3w"
            
        }else {
           availability_type = "week"
        }
        
        seleGender = selectedGender
        
        if selectedPrice == "1-20"{
            price = "1-10"
            
        }else if selectedPrice == "20-30" {
            price = "20-30"
            
        }else if selectedPrice == "30+" {
            price = "30"
            
        }
        self.onClickDone?(availability_type,seleGender,price)
    }
    
}




extension FilterViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = Bundle.main.loadNibNamed("FilterHeaderView", owner: self, options: nil)?.first as? FilterHeaderView
        headerView?.lbl.text = sectionHeader[section]
        headerView?.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        headerView?.addTap {
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.3))
        view.backgroundColor = section != 2 ? UIColor(named: "TextForegroundColor") : .clear
        return view
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return availabitlityArr.count
        case 1:
            return genderArr.count
        case 2:
            return consultationArr.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
//        switch indexPath.section {
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? FilterCell
//            cell?.titleLbl.text = self.selectedData?[indexPath.section].row[indexPath.row].valueName // genderArr[indexPath.row]
//            if let data = self.selectedData?[indexPath.section].row[indexPath.row].isSelected{
////                print(self.selectedData
//                self.selectedGender = data
//                cell?.setBoxImageForSelection = data
//        }
//            return cell!

//        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? FilterCell
            
            for i in 0...(self.selectedData?[indexPath.section].row.count)! {
                if self.selectedData?[indexPath.section].row[indexPath.row].isSelected == true {
                    cell?.setCirlceImageForSelection = true
                    switch indexPath.section {
                    case 0:
                        self.selectedAvailablity = self.selectedData?[indexPath.section].row[indexPath.row].valueName ?? "0"
                    case 1:
                        self.selectedGender = self.selectedData?[indexPath.section].row[indexPath.row].valueName ?? "0"
                    case 2:
                        
                        self.selectedPrice = self.selectedData?[indexPath.section].row[indexPath.row].valueName ?? "0"
                    default:
                        break
                    }
                    

                }else{
                    cell?.setCirlceImageForSelection = false

                    
                }
            }
            cell?.titleLbl.text = self.selectedData?[indexPath.section].row[indexPath.row].valueName // genderArr[indexPath.row]
           
            return cell!
        }
         
//    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                    
        var dat1 = 0
        let dat2 = indexPath.row
        
        if indexPath.section != 1 {

            for i in 0..<(self.selectedData?[indexPath.section].row.count)! {
                if dat1 != dat2 {
                        self.selectedData?[indexPath.section].row[i].isSelected = false
                    dat1 += 1
                }else{
//                    cell?.setCirlceImageForSelection = false

                    self.selectedData?[indexPath.section].row[i].isSelected = true
                    dat1 += 1

                }
            }
            self.fileterTableView.reloadData()

        }else{
            
            if var data = self.selectedData?[indexPath.section].row[indexPath.row].isSelected{
                
                data = data ? false : true
                self.selectedData?[indexPath.section].row[indexPath.row].isSelected = data
            }
            self.fileterTableView.reloadData()

        }
       
     }
    
}




struct valueData {
    
    var sectionName : String?
    var row : [rRow]
    
    
}

struct rRow {
    var valueName : String?
    var row : Int?
    var isSelected : Bool?

}
