//
//  ReviewCell.swift
//  MiDokter User
//
//  Created by AppleMac on 12/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import Foundation
import UIKit

class ReviewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var dateLbl : UILabel!
    @IBOutlet weak var visitForLbl : UILabel!
    @IBOutlet weak var deasesLbl : UILabel!
    @IBOutlet weak var reviewLbl : UILabel!
    @IBOutlet weak var thumpsupImg : UIImageView!
    @IBOutlet weak var thumpsupBGView : UIView!
    @IBOutlet weak var reviewBgView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.thumpsupBGView.layer.borderColor = UIColor.appColor.cgColor
        self.thumpsupBGView.layer.borderWidth = 1
        self.thumpsupBGView.layer.cornerRadius = self.thumpsupImg.frame.width/2
        self.reviewBgView.setCorneredElevation(shadow: 1, corner: 10, color: .appColor)
    }
}
