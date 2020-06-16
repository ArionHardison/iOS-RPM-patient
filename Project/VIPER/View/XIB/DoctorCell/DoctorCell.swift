//
//  DoctorCell.swift
//  Project
//
//  Created by Chan Basha on 24/04/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class DoctorCell: UITableViewCell {

    @IBOutlet weak var docterImage : UIImageView!
    @IBOutlet weak var docterName : UILabel!
    @IBOutlet weak var SplistLbl : UILabel!
    @IBOutlet weak var DoctorTypeLbl : UILabel!
    @IBOutlet weak var ExpncLbl : UILabel!
    @IBOutlet weak var availablityLbl : UILabel!
    @IBOutlet weak var likeCountLbl : UILabel!
    @IBOutlet weak var clinicNameLbl : UILabel!
    @IBOutlet weak var feeLbl : UILabel!
    @IBOutlet weak var callBtn : UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
