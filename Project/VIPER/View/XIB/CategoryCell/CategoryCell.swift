//
//  CategoryCell.swift
//  Project
//
//  Created by Chan Basha on 23/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryImg: UIImageView!
    
    @IBOutlet weak var labelCategoryName: UILabel!
    @IBOutlet weak var leftstripeview: UIView!
    @IBOutlet weak var rightstripeview: UIView!
    
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var leftLbl: UILabel!
    @IBOutlet weak var rightLbl: UILabel!
    @IBOutlet weak var bottomLbl: UILabel!

    
    
    var LeftborderSet = false {
        
        didSet{
            
            
//            self.topLbl.isHidden = LeftborderSet
//            self.leftLbl.isHidden = LeftborderSet
//            self.rightLbl.isHidden = !LeftborderSet
//            self.bottomLbl.isHidden = !LeftborderSet
//            self.leftstripeview.isHidden = LeftborderSet
//            self.rightstripeview.isHidden = !LeftborderSet
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        Common.setFont(to: labelCategoryName, isTitle: false, size: 12)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.borderLineWidth = 1
        self.contentView.borderColor = UIColor(named: "TextBlackColor")!

        categoryImg.cornerRadius = self.categoryImg.frame.height/2

    }

}
