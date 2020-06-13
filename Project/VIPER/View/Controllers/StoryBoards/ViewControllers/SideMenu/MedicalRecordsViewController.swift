//
//  MedicalRecordsViewController.swift
//  MiDokter User
//
//  Created by Vinod Reddy Sure on 12/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class MedicalRecordsViewController: UIViewController {

    @IBOutlet weak var listTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

}

extension MedicalRecordsViewController {
    func initialLoads() {
        registerCell()
        setupNavigationBar()

    }
    private func setupNavigationBar() {
         self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Medical Records"
         Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
         self.navigationController?.navigationBar.isTranslucent = false
         self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
    }

    func registerCell(){
        self.listTable.registerCell(withId: XIB.Names.FavDoctorTableViewCell)
        
        self.listTable.tableFooterView = UIView()
    }
}

extension MedicalRecordsViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.listTable.dequeueReusableCell(withIdentifier: XIB.Names.FavDoctorTableViewCell, for: indexPath) as! FavDoctorTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
