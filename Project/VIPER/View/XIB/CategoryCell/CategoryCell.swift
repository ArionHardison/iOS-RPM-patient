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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categoryImg.makeRoundedCorner()
        Common.setFont(to: labelCategoryName, isTitle: false, size: 15)
    }

}
