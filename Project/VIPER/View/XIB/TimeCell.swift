//
//  TimeCell.swift
//  MiDokter User
//
//  Created by Basha's MacBook Pro on 12/11/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class TimeCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLbl : UILabel!
    @IBOutlet weak var meridianLbl : UILabel!
    @IBOutlet weak var timeView : UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.timeView.makeRoundedCorner()
        
        
    }

}
