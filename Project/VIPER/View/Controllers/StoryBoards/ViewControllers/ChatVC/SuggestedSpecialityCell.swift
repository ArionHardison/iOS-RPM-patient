//
//  SuggestedSpecialityCell.swift
//  Project
//
//  Created by Hari Haran on 04/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class SuggestedSpecialityCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
