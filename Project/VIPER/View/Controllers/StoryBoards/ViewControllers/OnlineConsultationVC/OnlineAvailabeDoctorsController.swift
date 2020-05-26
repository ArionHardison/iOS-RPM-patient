//
//  OnlineAvailabeDoctorsController.swift
//  Project
//
//  Created by Chan Basha on 23/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class OnlineAvailabeDoctorsController: UIViewController {

    @IBOutlet weak var doctorsListTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       registerCell()
        setNav()
       
    }
    
    
    
    private func registerCell(){
        
       
        doctorsListTV.register(UINib(nibName: XIB.Names.OnlineDoctorCell, bundle: .main), forCellReuseIdentifier:  XIB.Names.OnlineDoctorCell)
        
    }
    
    func setNav() {
        self.navigationController?.isNavigationBarHidden = false
       self.navigationItem.title = "Online Consultants"
        Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

}
extension OnlineAvailabeDoctorsController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.OnlineDoctorCell, for: indexPath) as! OnlineDoctorCell
        cell.selectionStyle = .none
        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
  
    
}
