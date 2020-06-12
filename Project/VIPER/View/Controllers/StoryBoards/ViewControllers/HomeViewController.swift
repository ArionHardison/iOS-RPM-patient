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
       
            var dict = [String:Any]()
            
            // Add a new enter code herekey with a value
            dict["email"] = "sample@email.com"
            dict["name"] = "Deepika"
            print(dict)
            
            dictionary["road"] = "Street, No: 12 Ponni nager"
            dictionary["test"] = "test 1"
            print("****dictionary",dictionary)
           
            
            
        }
     
       
              
    }
    
    // MARK:- Methods
    
    extension HomeViewController {
        
        private func initialLoads() {
            self.viewSideMenu.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.sideMenuAction)))
            
            let email = "demo@demo.com"
            var login = LoginParameters()
            login.username = email
            login.password = "123456"
            login.client_id = appClientId
            login.client_secret = appSecretKey
            login.device_id = deviceId
            login.device_type = "ios"
            login.device_token = deviceTokenString
            self.loader.isHidden = false
            
           /* self.presenter?.GETPOST(api: Base.signIn.rawValue, params: login.toLoginParameters(), methodType: .POST, modelClass: LoginModel.self, token: false) */
            
            self.presenter?.HITAPI(api: "api/v1/create", params: ["name":"test","salary":"123","age":"23"], methodType: .POST, modelClass: Json4Swift_Base.self, token: false)
            
            
            let image =  UIImageView(image: UIImage(imageLiteralResourceName: "google"))
            searchBar.searchTextField.leftViewMode = .never
           
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.rightView = image
//            let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
//            var imageView = textFieldInsideSearchBar?.leftView as! UIImageView
//
//            imageView =  UIImageView(image: UIImage(imageLiteralResourceName: "google"))
//
            
            searchBar.searchTextField.rightViewMode = .always
            
            self.listTableView.register(UINib(nibName: XIB.Names.LogoCell, bundle: .main), forCellReuseIdentifier: XIB.Names.LogoCell)
            
         
        }
        
       
        override func viewWillAppear(_ animated: Bool) {
            
            
            
//                    let searchBar = UISearchBar()
//                    searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60)
//                    searchBar.backgroundColor = .red
//                    searchBar.placeholder = "Enter your name"
//                    searchBar.delegate = self
//                    self.navigationController?.navigationItem.titleView  = searchBar
//
            
            self.navigationController?.navigationBar.isHidden = true
            
        }
        
        
       
        // MARK:- SideMenu Button Action
        
        @IBAction private func sideMenuAction(){
            
                self.drawerController?.openSide(.left)
                self.viewSideMenu.addPressAnimation()
         }
        
        
//       override var prefersStatusBarHidden: Bool
//        {
//
//        return true
//
//        }
      
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
                    self.push(id: Storyboard.Ids.ChatTableViewController, animation: true)
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
    
  
    
    // MARK:- PostViewProtocol
    
    extension HomeViewController: PresenterOutputProtocol {
        
        func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
            print("Called")
            if String(describing: modelClass) == model.type.Json4Swift_Base {
                self.loader.isHidden = true
                self.userDataResponse = dataDict as? Json4Swift_Base
                print("*********Token", self.userDataResponse?.success?.text)
                print(self.userDataResponse as Any)
                
            }
        }
        
        func showError(error: CustomError) {
            self.loader.isHidden = true
            print(error)
        }
        
      
        
    }

    
    struct model {
        
        static let type = model()
        
        let RegisterModel = "RegisterModel"
        let LoginModel = "LoginModel"
        let Json4Swift_Base = "Json4Swift_Base"
        
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
