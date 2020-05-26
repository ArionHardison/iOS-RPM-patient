//
//  OnlineDoctorCell.swift
//  Project
//
//  Created by Chan Basha on 15/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class OnlineDoctorCell: UITableViewCell {

    
    @IBOutlet weak var docotrImage: UIImageView!
    
    @IBOutlet weak var onlineImg: UIImageView!
    @IBOutlet weak var labelDocotrName: UILabel!
    
    
    
    @IBOutlet weak var labelTiming: UILabel!
    
    @IBOutlet weak var labelSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
