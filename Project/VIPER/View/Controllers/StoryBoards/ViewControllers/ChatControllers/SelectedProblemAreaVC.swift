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
    @IBOutlet weak var topLbl : UILabel!

    var category : [Category] = [Category]()
    
    var selectedCategory : ((Category,Int)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()
    }
    
    func initialsetup(){
        self.setupFont()
        self.setupAction()
        self.setupCollectionViewCell()
    }
    
    
    func setupAction(){
        self.cancelBtn.addTap {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupView()

    }
    
    func setupView(){
        
        self.selectionTomView.roundCorners(corners: [.topLeft,.topRight], radius: 15)
    }
    
    func setupFont(){
        Common.setFontWithType(to: self.cancelBtn, size: 20, type: .regular)
        Common.setFontWithType(to: self.topLbl, size: 18, type: .regular)
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
        cell.orginalPrizeLbl.text = "$" + "\(self.category[indexPath.row].fees ?? 0)"
        cell.offerPrizeLbl.text = "$" + (self.category[indexPath.row].offer_fees ?? "")
//        let url = baseUrl + "/storage/" + (self.category[indexPath.row].image ?? "")
        cell.problemsImg.setURLImage(self.category[indexPath.row].image ?? "")
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
//        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
//        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: Double(self.problemsList.frame.width/2.05), height: 110)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCategory?(self.category[indexPath.row],indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }

    func setupCollectionViewCell(){
        
        self.problemsList.registerCell(withId: XIB.Names.ProblemCell)
    }
    

    
}
