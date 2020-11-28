//
//  RelativeManagementViewController.swift
//  MiDokter User
//
//  Created by Sethuram Vijayakumar on 10/11/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class RelativeManagementViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var relativeTableView: UITableView!
    @IBOutlet var titleView: UIView!
    @IBOutlet weak var addNewRelativeButton: UIButton!
    
    
    var relatives = [Relatives]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalLoads()
        self.setUpNavigation()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.callForRelatives()
    }
    
}


extension RelativeManagementViewController {
    
    
    private func initalLoads(){
//        self.backButton.setImage(UIImage(systemName: ""), for: .normal)
        self.titleLabel.text = "Relatives Management"
        self.titleLabel.textColor = .white
        self.backButton.tintColor = .white
        self.relativeTableView.register(UINib(nibName: XIB.Names.RelativesTableViewCell, bundle: nil), forCellReuseIdentifier: XIB.Names.RelativesTableViewCell)
        self.relativeTableView.delegate = self
        self.relativeTableView.dataSource = self
        self.backButton.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        self.addNewRelativeButton.addTarget(self, action: #selector(newButtonAction(sender:)), for: .touchUpInside)
    }
    
    
    private func setUpNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Relative Management"
    }
    
    private func callForRelatives(){
        let url = "\(Base.getRelative.rawValue)?patient_id=\(UserDefaultConfig.PatientID)"
        self.presenter?.HITAPI(api:url, params: nil, methodType: .GET, modelClass: RelativeManagement.self, token: true)
    }
    
    @IBAction private func newButtonAction(sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.RelativeDetailViewController) as! RelativeDetailViewController
        vc.isNewRelative = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



extension RelativeManagementViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return relatives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.RelativesTableViewCell, for: indexPath) as! RelativesTableViewCell
        cell.labeRelativeName.text = (relatives[indexPath.row].first_name ?? "") + (relatives[indexPath.row].last_name ?? "")
        cell.labelRelativeAge.text = "\(relatives[indexPath.row].profile?.age ?? "") Years of age"
        cell.profileImageView.setURLImage(relatives[indexPath.row].profile?.profile_pic ?? "")
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.RelativeDetailViewController) as! RelativeDetailViewController
        vc.userRelatives = self.relatives[indexPath.row]
        vc.isNewRelative = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.3
        
    }
    
    
    
    
}


extension RelativeManagementViewController : PresenterOutputProtocol {
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        DispatchQueue.main.async {
            switch String(describing: modelClass) {
                case model.type.RelativeManagement:
                    
                    let data = dataDict as? RelativeManagement
                    self.relatives = data?.relatives ?? []
                    self.relativeTableView.reloadInMainThread()
                    
                    break
                
                default: break
                
            }
            
        }
    }
    
    func showError(error: CustomError) {
        showToast(msg: error.localizedDescription)
    }
    
    
}
