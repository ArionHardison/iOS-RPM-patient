//
//  VisitedDoctorsViewController.swift
//  Project
//
//  Created by Hari Haran on 03/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class VisitedDoctorsViewController: UIViewController {
    
    @IBOutlet weak var visitedDoctorsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
}

//MARK: View Setups
extension VisitedDoctorsViewController {
    
    private func initialLoads() {
        setupNavigationBar()
        registerCell()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Visited Doctors"
    }
    
    private func registerCell() {
        self.visitedDoctorsTable.tableFooterView = UIView()
        self.visitedDoctorsTable.register(UINib(nibName: XIB.Names.VisitedDoctorsCell, bundle: nil), forCellReuseIdentifier: XIB.Names.VisitedDoctorsCell)
    }
}

//MARK: Tabelview delegates and datasources

extension VisitedDoctorsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.VisitedDoctorsCell) as? VisitedDoctorsCell else{
            return UITableViewCell()
        }
        cell.customizeStatusColor(indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(id: Storyboard.Ids.AppointmentDetailsViewController, animation: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

