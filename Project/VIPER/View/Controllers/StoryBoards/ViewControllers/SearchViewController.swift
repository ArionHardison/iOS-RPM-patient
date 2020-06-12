//
//  SearchViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 12/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var searchResult : UITableView!
    @IBOutlet weak var searchCountLbl : UILabel!
    
    var searchArray : [SearchDoc] = [SearchDoc]()
    
    func setupDemoData(){
        self.searchArray.append(SearchDoc(name: "Dr.Alvin", degree: "MBBS, MS", specialist: "General Physician"))
        self.searchArray.append(SearchDoc(name: "Dr.Richard", degree: "MBBS, MS", specialist: "Opthalmologist"))
        self.searchArray.append(SearchDoc(name: "Dr.Glen Stwacy", degree: "MBBS, MRCP (UK)", specialist: "General Physician"))
        self.searchArray.append(SearchDoc(name: "Dr.Alvin", degree: "MBBS, MS", specialist: "General Physician"))
        self.searchArray.append(SearchDoc(name: "Dr.Alvin", degree: "MBBS, MS", specialist: "General Physician"))
        self.searchResult.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initailSetup()
        self.setupDemoData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func initailSetup(){
        self.setupTableViewCell()
        self.setupNavigation()
        Common.setFont(to: self.searchCountLbl)
        self.setSeatchCountLbl()
    }
    
    func setupNavigation(){
        self.title = "Search Doctors"
    }
    
    
    
    // MARK:- set Multiple color for single lable
    
    func setSeatchCountLbl(resultCount : Int = 0){
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.appColor]
        
        let attributedString1 = NSMutableAttributedString(string:"Search results for Miot ", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:"(\(resultCount) results found)", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        self.searchCountLbl.attributedText = attributedString1
    }
    
}



extension SearchViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.SearchCell) as! SearchCell
        if let search : SearchDoc  = self.searchArray[indexPath.row]{
            cell.docNameLbl.text = search.name
            cell.docDegreeLbl.text = search.degree
            cell.docSpecialtLbl.text = search.specialist
        }
        self.SearchCellAction(cell: cell)
        return cell
        
    }
    
    func SearchCellAction(cell : SearchCell){
        cell.contentView.addTap {
            self.push(id: Storyboard.Ids.DoctorDetailsController, animation: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func setupTableViewCell(){
        self.searchResult.registerCell(withId: XIB.Names.SearchCell)
    }
    
}


struct SearchDoc {
    var name : String = ""
    var degree : String = ""
    var specialist : String = ""
}
