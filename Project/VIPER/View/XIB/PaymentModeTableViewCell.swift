//
//  PaymentModeTableViewCell.swift
//  MiDokter User
//
//  Created by Sethuram Vijayakumar on 17/12/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class PaymentModeTableViewCell: UITableViewCell {
    @IBOutlet weak var paymentImageView: UIImageView!
    @IBOutlet weak var paymentTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
