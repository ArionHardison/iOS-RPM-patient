//
//  VisitedDoctorsCell.swift
//  Project
//
//  Created by Hari Haran on 03/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class VisitedDoctorsCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var hospitalNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateTimeStack: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        designSetup()
        setText()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func designSetup() {
        dateTimeStack.layer.borderWidth = 1
        dateTimeStack.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setText() {
        Common.setFont(to: dateLabel)
        Common.setFont(to: timeLabel)
        Common.setFont(to: doctorNameLabel)
        Common.setFont(to: hospitalNameLabel)
        Common.setFont(to: statusLabel)
    }
    
    func customizeStatusColor(indexPath:IndexPath) {
        statusLabel.textColor = indexPath.row % 2 == 0 ? UIColor.green : UIColor.red
        statusLabel.backgroundColor = indexPath.row % 2 == 0 ? UIColor.green.withAlphaComponent(0.1) : UIColor.red.withAlphaComponent(0.1)
    }
    
}
