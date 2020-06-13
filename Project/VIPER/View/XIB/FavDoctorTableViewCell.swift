//
//  FavDoctorTableViewCell.swift
//  MiDokter User
//
//  Created by Vinod Reddy Sure on 12/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class FavDoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSpeciality: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
