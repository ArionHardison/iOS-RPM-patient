//
//  UpcomingTableviewCell.swift
//  Project
//
//  Created by Chan Basha on 15/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class UpcomingTableviewCell: UITableViewCell {
    
    
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labeldoctorName: UILabel!
    
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var labelStatus: PaddingLabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var makeVideoCallButton: UIButton!
    
    @IBOutlet weak var statusWidth: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorners(cornerRadius: 6, cornerView: dateView)
//        self.roundCorners(cornerRadius: 6, cornerView: labelStatus)

//        self.dateView.roundCorners(corners: [.topRight,.bottomRight], radius: 6)
        self.labelStatus.roundCorners(corners: [.bottomLeft,.topLeft], radius: 6)
        self.dateView.borderLineWidth = 1.0
        
        
    }

    func roundCorners(cornerRadius: Double,cornerView:UIView) {
        cornerView.layer.cornerRadius = CGFloat(cornerRadius)
        cornerView.clipsToBounds = true
        cornerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
}
