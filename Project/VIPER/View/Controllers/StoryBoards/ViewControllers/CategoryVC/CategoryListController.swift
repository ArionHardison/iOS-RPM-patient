//
//  CategoryListController.swift
//  Project
//
//  Created by Chan Basha on 23/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper
import IQKeyboardManagerSwift

class CategoryListController: UIViewController {
    
    @IBOutlet weak var categoryListCV: UICollectionView!
    @IBOutlet weak var doctorSearchBar: UISearchBar!
    
      var category : [Category] = [Category]()
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        self.doctorSearchBar.delegate = self
        registerCell()
        setNav()
        if let layout = categoryListCV?.collectionViewLayout as? UICollectionViewFlowLayout{
        layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 0)
        let size = CGSize(width:categoryListCV.bounds.width/2, height: 175)
        layout.itemSize = size
        }
        self.doctorSearchBar.change(textFont: .systemFont(ofSize: 17))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.getCatagoryList()
    }
    
    
    
    func setNav() {
        
           self.navigationController?.isNavigationBarHidden = false
          self.navigationItem.title = "Find Doctors"
           Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
           self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
           self.navigationController?.navigationBar.isTranslucent = false
           self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
       }
 
    private func registerCell(){
       
        
        categoryListCV.register(UINib(nibName: XIB.Names.CategoryCell, bundle: .main), forCellWithReuseIdentifier: XIB.Names.CategoryCell)
        
    
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }

}

extension CategoryListController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
        {
        
       
            return self.category.count
        
        
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.Names.CategoryCell, for: indexPath) as! CategoryCell
        cell.labelCategoryName.text = self.category[indexPath.row].name
        let imageurl = self.category[indexPath.row].image ?? ""
        print(imageurl)
        cell.categoryImg.setURLImage(imageurl)
//        if indexPath.row % 2 == 0{
//            cell.LeftborderSet = true
////            cell.leftstripeview.isHidden = false
//        }else{
//            cell.LeftborderSet = false
//
////            cell.leftstripeview.isHidden = true
//        }
        return cell
        
    }
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2
        return CGSize(width: size, height: size - 60)
        
       }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DoctorsListController.initVC(storyBoardName: .main, vc: DoctorsListController.self, viewConrollerID: "DoctorsListController")
        vc.catagoryID = self.category[indexPath.row].id ?? 0
        self.push(from: self, ToViewContorller: vc)
    }


    
}


//Api calls
extension CategoryListController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.CategoryList:
                
                let data = dataDict as? CategoryList
                self.category = data?.category ?? [Category]()
                self.categoryListCV.reloadData()
                break
           
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getCatagoryList(){
        self.presenter?.HITAPI(api: Base.catagoryList.rawValue, params: nil, methodType: .GET, modelClass: CategoryList.self, token: true)
    }
    
    func cancelAppointment(id : String){
        self.presenter?.HITAPI(api: Base.cancelAppointment.rawValue, params: ["id" : id], methodType: .POST, modelClass: CommonModel.self, token: true)
    }
}


extension CategoryListController : UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.push(id: Storyboard.Ids.SearchViewController, animation: true)
        return false
    }
    
    
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
          print("end searching --> Close Keyboard")
          self.doctorSearchBar.endEditing(true)
      }
    
    
}


extension UISearchBar {

func change(textFont : UIFont?) {

    for view : UIView in (self.subviews[0]).subviews {

        if let textField = view as? UITextField {
            textField.font = textFont
        }
    }
} }
