//
//  RelativesTableViewCell.swift
//  MiDokter User
//
//  Created by Sethuram Vijayakumar on 10/11/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class RelativesTableViewCell: UITableViewCell {
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var labeRelativeName: UILabel!
    @IBOutlet weak var labelRelativeAge: UILabel!
    @IBOutlet weak var nextImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.makeRoundedCorner()

    }
}

extension RelativesTableViewCell {
    func makeRounded() {

         layer.borderWidth = 1
         layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
         layer.cornerRadius = frame.height/2
         clipsToBounds = true
     }
}
