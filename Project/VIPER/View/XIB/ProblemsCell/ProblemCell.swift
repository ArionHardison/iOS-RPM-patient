//
//  ProblemCell.swift
//  MiDokter User
//
//  Created by AppleMac on 13/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class ProblemCell: UICollectionViewCell {
    
    @IBOutlet weak var problemsBGView : UIView!
    @IBOutlet weak var problemsImg : UIImageView!
    @IBOutlet weak var problemsLbl : UILabel!
    @IBOutlet weak var orginalPrizeLbl : UILabel!
    @IBOutlet weak var orginalPrizeView : UIView!
    @IBOutlet weak var offerPrizeLbl : UILabel!
    
    override func awakeFromNib() {
        superview?.awakeFromNib()

        self.setupFont()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.problemsBGView.setCorneredElevation(shadow: 0, corner: 10, color: UIColor.clear)
        self.problemsImg.cornerRadius = self.problemsImg.frame.height/2
    }
    
    func setupFont(){
//        Common.setFont(to: self.problemsLbl, isTitle: false, size: 18)
//        Common.setFont(to: self.orginalPrizeLbl, isTitle: false, size: 15)
//        Common.setFont(to: self.offerPrizeLbl, isTitle: false, size: 18)
    }
}
