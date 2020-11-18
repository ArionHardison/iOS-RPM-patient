//
//  AddAllergyTableViewCell.swift
//  MiDokter User
//
//  Created by Sethuram Vijayakumar on 17/11/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class AddAllergyTableViewCell: UITableViewCell {
    @IBOutlet weak var labelAddAlergy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.labelAddAlergy.text = Constants.string.addanallerygy.localize()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
