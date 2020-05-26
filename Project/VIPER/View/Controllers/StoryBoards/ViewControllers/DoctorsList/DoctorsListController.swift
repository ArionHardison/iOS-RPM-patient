//
//  DoctorsListController.swift
//  Project
//
//  Created by Chan Basha on 24/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class DoctorsListController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var doctorsListTV: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initilaLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
           self.navigationController?.navigationBar.isHidden = true
       }
       
     
    private func initilaLoads(){
        
   
        doctorsListTV.register(UINib(nibName: XIB.Names.DoctorCell, bundle: .main), forCellReuseIdentifier:  XIB.Names.DoctorCell)
        self.btnBack.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)

    }
    
    
       
}

extension DoctorsListController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 15
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
  
        
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.DoctorCell, for: indexPath) as! DoctorCell
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    

    
    
}
