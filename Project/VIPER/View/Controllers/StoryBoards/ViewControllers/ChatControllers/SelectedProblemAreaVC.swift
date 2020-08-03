//
//  SelectedProblemAreaVC.swift
//  MiDokter User
//
//  Created by AppleMac on 13/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class SelectedProblemAreaVC: UIViewController {
    
    @IBOutlet weak var cancelBtn : UIButton!
    @IBOutlet weak var selectionTomView : UIView!
    @IBOutlet weak var problemsList : UICollectionView!

    var category : [Category] = [Category]()
    
    var selectedCategory : ((Category)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()
    }
    
    func initialsetup(){
        self.setupView()
        self.setupFont()
        self.setupAction()
        self.setupCollectionViewCell()
    }
    
    
    func setupAction(){
        self.cancelBtn.addTap {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setupView(){
        selectionTomView.clipsToBounds = true
        selectionTomView.layer.cornerRadius = 20
        selectionTomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func setupFont(){
        Common.setFont(to: self.cancelBtn, isTitle: true, size: 20)
    }
    
}

extension SelectedProblemAreaVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
         return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.Names.ProblemCell, for: indexPath) as! ProblemCell
        cell.problemsLbl.text = self.category[indexPath.row].name
        cell.orginalPrizeLbl.text = self.category[indexPath.row].fees
        cell.offerPrizeLbl.text = self.category[indexPath.row].offer_fees
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
//        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
//        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: Double(self.problemsList.frame.width/2), height: 120)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCategory?(self.category[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }

    func setupCollectionViewCell(){
        
        self.problemsList.registerCell(withId: XIB.Names.ProblemCell)
    }
    

    
}
