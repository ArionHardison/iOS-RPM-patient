//
//  ReminderCell.swift
//  Project
//
//  Created by Chan Basha on 15/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class ReminderCell: UITableViewCell {
    
    
    @IBOutlet weak var viewBG: UIView!
    
    @IBOutlet weak var labelFirstChar: UILabel!
    
    @IBOutlet weak var labelReason: UILabel!
    
    @IBOutlet weak var labelTiming: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBG.layer.cornerRadius = self.viewBG.frame.width / 2
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
