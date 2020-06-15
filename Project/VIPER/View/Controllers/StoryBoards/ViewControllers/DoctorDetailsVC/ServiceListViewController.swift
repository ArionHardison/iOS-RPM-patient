//
//  ServiceListViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 13/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class ServiceListViewController: UIViewController {
    
    @IBOutlet weak var serviceListTable : UITableView!

    //inital static Data
    var serviceList : [String] = ["Vaccination/Immunization","Adolescent Medicine","New Born Care","Infant & Child nutrition","Vaccination/Immunization","Adolescent Medicine","New Born Care","Infant & Child nutrition","Vaccination/Immunization","Adolescent Medicine","New Born Care","Infant & Child nutrition"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoads()
    }
    
    private func initialLoads() {
        setupNavigationBar()
        self.setupTableViewCell()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Service List"
        
    }
    
}


extension ServiceListViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.serviceListTable{
            return self.serviceList.count
        }
        else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ServiceSpecializationCell) as! ServiceSpecializationCell
        
        if tableView == self.serviceListTable{
            cell.serviceLbl.text = self.serviceList[indexPath.row]
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func setupTableViewCell(){
        self.serviceListTable.registerCell(withId: XIB.Names.ServiceSpecializationCell)
    }

}

