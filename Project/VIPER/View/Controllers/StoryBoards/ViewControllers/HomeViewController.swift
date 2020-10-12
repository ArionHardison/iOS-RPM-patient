    //
    //  HomeViewController.swift
    //  User
    //
    //  Created by CSS on 02/05/18.
    //  Copyright © 2018 Appoets. All rights reserved.
    //
    
    import UIKit
    import Foundation
    import ObjectMapper
    import KWDrawerController
    
    class HomeViewController: UIViewController ,UISearchBarDelegate{
        
        @IBOutlet private var viewSideMenu : UIView!
        private var userDataResponse: Json4Swift_Base?
        var dictionary =  [String:String]()
        
        @IBOutlet weak var listTableView: UITableView!
        @IBOutlet weak var searchBar: UISearchBar!
        
        lazy var loader : UIView = {
            return createActivityIndicator(UIApplication.shared.keyWindow ?? self.view)
        }()
        
        var titles = ["Find Doctors","Chat","Search Doctors","Visited Doctors"]
        var subTitles = ["Specialities","Ask Question on health related","Base on Hospitals","See you visited doctors"]
        var imageArray = ["Group 9","Group 9","Group 9","Group 9"]
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.initialLoads()
            
            
            
        }
        
        
        
        override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.isNavigationBarHidden = true
            self.getProfileApi()
        }
        
        
        
    }
    
    // MARK:- Methods
    
    extension HomeViewController {
        
        private func initialLoads() {
            self.viewSideMenu.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.sideMenuAction)))
            
            let image =  UIImageView(image: UIImage(imageLiteralResourceName: "google"))
            searchBar.searchTextField.leftViewMode = .never
            
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.rightView = image
            searchBar.searchTextField.rightViewMode = .always
            self.listTableView.register(UINib(nibName: XIB.Names.LogoCell, bundle: .main), forCellReuseIdentifier: XIB.Names.LogoCell)
        }
        
        
        
        // MARK:- SideMenu Button Action
        
        @IBAction private func sideMenuAction(){
            
            self.drawerController?.openSide(.left)
            self.viewSideMenu.addPressAnimation()
        }
        
        
    }
    
    
    // MARK:- Tableview Delegates
    
    
    extension HomeViewController : UITableViewDelegate, UITableViewDataSource
    {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return titles.count + 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            
            if indexPath.row != titles.count {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.DoctorsListCell, for: indexPath) as! DoctorsListCell
                
                cell.imgDoctor.image = UIImage(imageLiteralResourceName: self.imageArray[indexPath.row])
                cell.labelName.text = titles[indexPath.row]
                cell.labelSpeciality.text = subTitles[indexPath.row]
                cell.selectionStyle  = .none
                return cell
                
            }else
            {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.LogoCell, for: indexPath) as! LogoCell
                cell.selectionStyle  = .none
                return cell
                
            }
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            
            switch indexPath.row {
                case 0:
                    self.push(id: Storyboard.Ids.CategoryListController, animation: true)
                case 1:
                    self.push(id: Storyboard.Ids.ChatQuestionViewController, animation: true)
                case 2:
                    self.push(id: Storyboard.Ids.SearchViewController, animation: true)
                case 3:
                    self.push(id: Storyboard.Ids.VisitedDoctorsViewController, animation: true)
                default:
                    self.push(id: Storyboard.Ids.VisitedDoctorsViewController, animation: true)
            }
            
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            if indexPath.row == titles.count{
                return 250
            }else{
                
                return 110
                
            }
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    //Api calls
    extension HomeViewController : PresenterOutputProtocol{
        func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
            switch String(describing: modelClass) {
                case model.type.ProfileModel:
                    let data = dataDict as? ProfileModel
                    UserDefaultConfig.PatientID = (data?.patient?.id ?? 0).description
                    profileDetali = data ?? ProfileModel()
                    break
                
                default: break
                
            }
        }
        
        func showError(error: CustomError) {
            
        }
        
        func getProfileApi(){
            self.presenter?.HITAPI(api: Base.profile.rawValue, params: nil, methodType: .GET, modelClass: ProfileModel.self, token: true)
        }
        
    }
    

    
    struct model {
        
        static let type = model()
        
        let RegisterModel = "RegisterModel"
        let LoginModel = "LoginModel"
        let Json4Swift_Base = "Json4Swift_Base"
        let MobileVerifyModel = "MobileVerifyModel"
        let SignupResponseModel = "SignupResponseModel"
        let AppointmentModel = "AppointmentModel"
        let CommonModel = "CommonModel"
        let CategoryList = "CategoryList"
        let DoctorsDetailModel = "DoctorsDetailModel"
        let ArticleModel = "ArticleModel"
        let MedicalRecordsModel = "MedicalRecordsModel"
        let DoctorsListModel = "DoctorsListModel"
        let ProfileModel = "ProfileModel"
        let FeedBackModel = "FeedBackModel"
        let BookingModel = "BookingModel"
        let PromoCodeEntity = "PromoCodeEntity"
        let ChatHistoryEntity = "ChatHistoryEntity"
    }
    
    
    
    class DoctorsListCell: UITableViewCell {
        
        @IBOutlet weak var imgDoctor: UIImageView!
        
        @IBOutlet weak var bgView: UIView!
        @IBOutlet weak var labelName: UILabel!
        
        @IBOutlet weak var labelSpeciality: UILabel!
        
        override func awakeFromNib() {
            
            Common.setFont(to: labelSpeciality, isTitle: false, size: 12)
            Common.setFont(to: labelName, isTitle: true, size: 16)
            imgDoctor.makeRoundedCorner()
            
        }
        
    }
