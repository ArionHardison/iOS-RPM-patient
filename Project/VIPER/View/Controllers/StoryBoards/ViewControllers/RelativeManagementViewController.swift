//
//  RelativeManagementViewController.swift
//  MiDokter User
//
//  Created by Sethuram Vijayakumar on 10/11/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class RelativeManagementViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var relativeTableView: UITableView!
    @IBOutlet var titleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalLoads()
        self.setUpNavigation()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}


extension RelativeManagementViewController {
    
    
    private func initalLoads(){
        self.backButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        self.titleLabel.text = "Relatives Management"
        self.titleLabel.textColor = .white
        self.backButton.tintColor = .white
        self.relativeTableView.register(UINib(nibName: XIB.Names.RelativesTableViewCell, bundle: nil), forCellReuseIdentifier: XIB.Names.RelativesTableViewCell)
        self.relativeTableView.delegate = self
        self.relativeTableView.dataSource = self
        self.backButton.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
    }
    
    
    private func setUpNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Relative Management"
    }
    
}



extension RelativeManagementViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.RelativesTableViewCell, for: indexPath) as! RelativesTableViewCell
        cell.labeRelativeName.text = "Test"
        cell.labelRelativeAge.text = "23 Years of age"
        cell.profileImageView.image = #imageLiteral(resourceName: "1")
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.RelativeDetailViewController) as! RelativeDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
}
