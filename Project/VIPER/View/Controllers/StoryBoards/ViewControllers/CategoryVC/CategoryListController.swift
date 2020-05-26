//
//  CategoryListController.swift
//  Project
//
//  Created by Chan Basha on 23/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class CategoryListController: UIViewController {
    
    @IBOutlet weak var categoryListCV: UICollectionView!
    
    
    let categoryListArray = ["Womens Health","Skin & Hair","Child Specialist","General Physician","Dental Care","Ear Nose Throat","Ayurvede","Bone & Joints","Sex Specialist","Eye Specialist","Digestive Issues","Mental Wellness","Physiotheraphy","Diabetes Management","Lungs & Breathing","Heart"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        registerCell()
        setNav()
//       guard let collectionView = categoryListCV, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//       flowLayout.minimumInteritemSpacing = 10
//       flowLayout.minimumLineSpacing = 10
//       flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
       
        
        
        if let layout = categoryListCV?.collectionViewLayout as? UICollectionViewFlowLayout{
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        let size = CGSize(width:(categoryListCV.bounds.width-30)/2, height: 175)
        layout.itemSize = size
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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
        
       
        return categoryListArray.count
        
        
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.Names.CategoryCell, for: indexPath) as! CategoryCell
        cell.labelCategoryName.text = self.categoryListArray[indexPath.row]
        return cell
        
    }
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
        
       }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.push(id: Storyboard.Ids.DoctorsListController, animation: true)
    }


    
}
