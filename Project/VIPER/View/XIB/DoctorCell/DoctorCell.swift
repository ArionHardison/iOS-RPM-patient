//
//  DoctorCell.swift
//  Project
//
//  Created by Chan Basha on 24/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class DoctorCell: UITableViewCell {

    @IBOutlet weak var docterImage : UIImageView!
    @IBOutlet weak var docterName : UILabel!
    @IBOutlet weak var SplistLbl : UILabel!
    @IBOutlet weak var DoctorTypeLbl : UILabel!
    @IBOutlet weak var ExpncLbl : UILabel!
    @IBOutlet weak var availablityLbl : UILabel!
    @IBOutlet weak var likeCountLbl : UILabel!
    @IBOutlet weak var clinicNameLbl : UILabel!
    @IBOutlet weak var feeLbl : UILabel!
    @IBOutlet weak var callBtn : UIButton!
    @IBOutlet weak var bookingBtn : UIButton!
    
    @IBOutlet weak var callImage : UIImageView!
    @IBOutlet weak var bookImage : UIImageView!

    @IBOutlet weak var likedView : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.docterImage.makeRoundedCorner()
        self.likedView.addShadow(color: .black, opacity: 0.1, offset: CGSize(width: 1.0, height: 1.0), radius: 0.5, rasterize: false, maskToBounds: false)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.callImage.image = self.callImage.image?.withRenderingMode(.alwaysTemplate)
        self.callImage.tintColor = .AppBlueColor
        
        self.bookImage.image = self.bookImage.image?.withRenderingMode(.alwaysTemplate)
        self.bookImage.tintColor = UIColor(named: "AquaBlue")
    
        [self.callBtn,bookingBtn].forEach { (btn) in
            
            btn?.cornerRadius = 5.0
            btn?.borderColor = .AppBlueColor
            btn?.borderLineWidth = 0.5
        }
    }
}
