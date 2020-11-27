//
//  SideBarTableViewController.swift
//  User
//
//  Created by CSS on 02/05/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit
import KWDrawerController
import ObjectMapper

class SideBarTableViewController: UITableViewController {
    
    @IBOutlet private var imageViewProfile : UIImageView!
    @IBOutlet private var labelName : UILabel!
    @IBOutlet private var labelProfileCompletion : UILabel!
    @IBOutlet private var viewPtofileBtn : UIButton!
    @IBOutlet private var viewShadow : UIView!
    @IBOutlet private weak var profileImageCenterContraint : NSLayoutConstraint!
    
    private let sideBarList = [Constants.string.appointments,Constants.string.onlineConsultations,Constants.string.favDoctor,Constants.string.medicalRecords,Constants.string.reminder,Constants.string.wallet,Constants.string.articles,Constants.string.relativesManagement,Constants.string.settings] //Constants.string.faqAndAdmin,
    
    private let imagesList = ["appointment","onlineConsultation","favdoctor","medicalRecords","reminder","wallet","articles","RelativesManagement","settings"] //"faq",
    private let cellId = "cellId"
    private lazy var loader : UIView = {
        
        return createActivityIndicator(self.view)
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoads()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.localize()
        self.setValues()
        self.navigationController?.isNavigationBarHidden = true
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setLayers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isStatusBarHidden = false
    }
    
   
    
}

// MARK:- Methods

extension SideBarTableViewController {
    
    private func initialLoads() {
        self.drawerController?.shadowOpacity = 0.2
        let fadeWidth = self.view.frame.width*(0.2)
        self.profileImageCenterContraint.constant = 0
        self.drawerController?.drawerWidth = Float(self.view.frame.width - fadeWidth)
        self.viewShadow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewAction)))
        self.setDesigns()
        self.setupAction()
    }
    
    func setupAction(){
        self.viewPtofileBtn.addTap {
            self.push(to: Storyboard.Ids.ProfileViewController)
            self.drawerController?.closeSide()
        }
    }
    
    // MARK:- Set Designs
    
    private func setLayers(){
        self.imageViewProfile.makeRoundedCorner()
    }
    
    
    // MARK:- Set Designs
    
    private func setDesigns () {
        
        Common.setFontWithType(to: labelName, size: 16, type: .meduim)
        Common.setFontWithType(to: labelProfileCompletion, size: 10, type: .regular)
        Common.setFontWithType(to: viewPtofileBtn, size: 10, type: .regular)

//        Common.setFont(to: labelName)
//        Common.setFont(to: labelProfileCompletion)
    }
    
    
    //MARK:- SetValues
    
    private func setValues(){
        let profile : ProfileModel = profileDetali
           self.labelName.text = "\(profile.patient?.first_name ?? "") \(profile.patient?.last_name ?? "")"
           self.labelProfileCompletion.text = "Profile Completed : \(profile.profile_complete ?? "")"
           self.imageViewProfile.setURLImage(profile.patient?.profile?.profile_pic ?? "")
       
   }
    
    
    
    // MARK:- Localize
    private func localize() {
        
        self.tableView.reloadData()
        
    }
    
    // MARK:- ImageView Action
    
    @IBAction private func imageViewAction() {
   
        
        self.drawerController?.closeSide()
        
    }
    
    
    // MARK:- Selection Action For TableView
    
    private func select(at indexPath : IndexPath) {
        
        switch (indexPath.section,indexPath.row) {
            
            case (0,0):
               self.push(to: Storyboard.Ids.AppointmentViewController)
               self.drawerController?.closeSide()
                
            case(0,1):
                self.push(to: Storyboard.Ids.OnlineAvailabeDoctorsController)
                self.drawerController?.closeSide()
                
            case(0,2):
                self.push(to: Storyboard.Ids.FavouriteDoctorsListController)
                self.drawerController?.closeSide()
                
            case(0,3):
                self.push(to: Storyboard.Ids.MedicalRecordsViewController)
                self.drawerController?.closeSide()
            
            case(0,4):
                self.push(to: Storyboard.Ids.ReminderViewController)
                self.drawerController?.closeSide()
            
            case(0,5):
                self.push(to: Storyboard.Ids.WalletViewController)
                self.drawerController?.closeSide()
            
            case(0,6):
            self.push(to: Storyboard.Ids.HealthFeedViewController)
            self.drawerController?.closeSide()
            
        case(0,7):
            self.push(to: Storyboard.Ids.RelativeManagementViewController)
            self.drawerController?.closeSide()
            
//        case(0,8):
//            self.push(to: Storyboard.Ids.FAQViewController)
//            self.drawerController?.closeSide()

        case (0,self.sideBarList.count-1):
            self.push(to: Storyboard.Ids.SettingsViewController)
            self.drawerController?.closeSide()
            
        default:
            break
        }
    }
    
    private func push(to identifier : String) {
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: identifier)
        (self.drawerController?.getViewController(for: .none) as? UINavigationController)?.pushViewController(viewController, animated: true)
    }
    
    
    // MARK:- Logout
    
    private func logout() {
        let alert = UIAlertController(title: nil, message: Constants.string.areYouSureWantToLogout.localize(), preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: Constants.string.logout.localize(), style: .destructive) { (_) in
            self.loader.isHidden = false
            self.presenter?.HITAPI(api: Base.logout.rawValue, params: nil, methodType: .POST, modelClass: LoginModel.self, token: false)
        }
        let cancelAction = UIAlertAction(title: Constants.string.Cancel.localize(), style: .cancel, handler: nil)
        
        alert.view.tintColor = .primary
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


// MARK:- TableView

extension SideBarTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.SideBarCell, for: indexPath) as! SideBarCell
      
        tableCell.labelTitle.text = self.sideBarList[indexPath.row]
        tableCell.menuImage.image = UIImage(imageLiteralResourceName: self.imagesList[indexPath.row])
        tableCell.selectionStyle = .none
      
   
        return tableCell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideBarList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.select(at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


// MARK:- PostViewProtocol

extension SideBarTableViewController : PresenterOutputProtocol {
    
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        DispatchQueue.main.async {
            self.loader.isHidden = true
            forceLogout()
        }
    }
    
    func showError(error: CustomError) {
        
        DispatchQueue.main.async {
            self.loader.isHidden = true
            showAlert(message: error.localizedDescription, okHandler: nil, fromView: self)
        }
    }
    
}



class SideBarCell: UITableViewCell {
    
    
    @IBOutlet  var menuImage :UIImageView!
    @IBOutlet  var labelTitle :UILabel!
    
  
    
    override func awakeFromNib() {
        
//        Common.setFont(to: labelTitle, isTitle: false, size: 16)
        Common.setFontWithType(to: labelTitle, size: 14, type: .regular)

        
    }
    
    
}
