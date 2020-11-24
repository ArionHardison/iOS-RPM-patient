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
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: PaddingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setText()
//        self.setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.leftView.roundCorners(corners: [.topRight,.bottomRight], radius: 6)
        self.statusLabel.roundCorners(corners: [.bottomLeft,.topLeft], radius: 2)
        self.leftView.borderLineWidth = 1.0
    }
    
  
    
    private func setText() {
//        Common.setFont(to: dateLabel, isTitle: false, size: 18)
//        Common.setFont(to: timeLabel, isTitle: false, size: 14)
//        Common.setFont(to: doctorNameLabel, isTitle: false, size: 20)
//        Common.setFont(to: hospitalNameLabel, isTitle: false, size: 14)
//        Common.setFont(to: statusLabel)
    }
    
//    func customizeStatusColor(indexPath:IndexPath) {
//        statusLabel.textColor = indexPath.row % 2 == 0 ? UIColor.green : UIColor.red
//        statusView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.green.withAlphaComponent(0.1) : UIColor.red.withAlphaComponent(0.1)
//    }
    
    func customizeStatusColor(status:String) {
        statusLabel.textColor = status == "CANCELLED" ? UIColor.red : UIColor.green
        statusView.backgroundColor = status == "CANCELLED" ? UIColor.red.withAlphaComponent(0.1) : UIColor.green.withAlphaComponent(0.1)
    }
}
