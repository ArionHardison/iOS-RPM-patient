//
//  SummaryViewController.swift
//  MiDokter User
//
//  Created by AppleMac on 13/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    
    
    @IBOutlet weak var backBtn : UIButton!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var proceedTPayBtn : UIButton!
    @IBOutlet weak var feeLbl : UILabel!
    @IBOutlet weak var offerPriceLbl : UILabel!
    @IBOutlet weak var orginalPrieLbl : UILabel!
    @IBOutlet weak var applyBtn : UIButton!
    @IBOutlet weak var moneyBack : UILabel!
    @IBOutlet weak var promoCode : UITextField!
    
    @IBOutlet weak var verifiedLbl : UILabel!
    @IBOutlet weak var chatoutLbl : UILabel!
    @IBOutlet weak var userCollection : UICollectionView!
    @IBOutlet weak var bottomView : UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()
    }
    
    func initialsetup(){
        self.setupAction()
        self.setupFont()
        self.navigationController?.isNavigationBarHidden = true
        
        
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.setSeatchCountLbl(price: 10)
    }
    
    func setupAction(){
        self.backBtn.addTap {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func setupFont(){
       
        
        Common.setFont(to: titleLbl, isTitle: true, size: 20)
        Common.setFont(to: feeLbl, isTitle: true, size: 18)
        Common.setFont(to: proceedTPayBtn, isTitle: true, size: 20)
        Common.setFont(to: backBtn, isTitle: true, size: 20)
        Common.setFont(to: offerPriceLbl, isTitle: false, size: 17)
        Common.setFont(to: orginalPrieLbl, isTitle: false, size: 15)
        Common.setFont(to: moneyBack, isTitle: false, size: 14)
        Common.setFont(to: verifiedLbl, isTitle: false, size: 16)
        Common.setFont(to: chatoutLbl, isTitle: false, size: 16)
        Common.setFont(to: promoCode, isTitle: false, size: 18)
    }
    
    func setSeatchCountLbl(price : Int = 0){
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.AppBlueColor]
        
        let attributedString1 = NSMutableAttributedString(string:" $ \(price) ", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:"(30% off)", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        self.orginalPrieLbl.attributedText = attributedString1
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
}
