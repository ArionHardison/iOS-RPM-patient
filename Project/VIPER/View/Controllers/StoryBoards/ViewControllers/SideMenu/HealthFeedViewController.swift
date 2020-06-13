//
//  HealthFeedViewController.swift
//  Mi Dokter
//
//  Created by Mithra Mohan on 17/03/20.
//  Copyright © 2020 Mithra Mohan. All rights reserved.
//

import UIKit

class HealthFeedViewController: UIViewController {

    @IBOutlet weak var tableViewHealthFeed: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }


}


extension HealthFeedViewController {
    func initialLoads() {
        registerCell()
        setupNavigationBar()

    }
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Articles"
         Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
         self.navigationController?.navigationBar.isTranslucent = false
         self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
    }

    func registerCell(){
        self.tableViewHealthFeed.registerCell(withId: XIB.Names.HealthFeedTableViewCell)
        
        self.tableViewHealthFeed.tableFooterView = UIView()
    }

    func setDesign() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: self.view.frame.height, height: 40))
        label.text = "Published Articles"
        label.textColor = .black
        headerView.addSubview(label)
        self.tableViewHealthFeed.tableHeaderView = headerView
        self.tableViewHealthFeed.separatorStyle = .none
    }
}


//MARK:- TABLEVIEW DELEGATES AND DATASOURCES

extension HealthFeedViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HealthFeedTableViewCell") as! HealthFeedTableViewCell
        cell.selectionStyle = .none
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.push(id: Storyboard.Ids.HealthFeedDetailsViewController, animation: true)
    }
    
    
}
