//
//  SearchCell.swift
//  MiDokter User
//
//  Created by AppleMac on 12/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var docImage : UIImageView!
    @IBOutlet weak var docNameLbl : UILabel!
    @IBOutlet weak var docDegreeLbl : UILabel!
    @IBOutlet weak var docSpecialtLbl : UILabel!
    @IBOutlet weak var rightarrow : UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    func setupView(){
        self.selectionStyle = .none
        Common.setFont(to: self.docNameLbl, isTitle: false, size: 20)
        Common.setFont(to: self.docDegreeLbl, isTitle: false, size: 15)
        Common.setFont(to: self.docSpecialtLbl, isTitle: false, size: 13)
        
        self.docImage.layer.cornerRadius = self.docImage.frame.width / 2
        self.docImage.layer.borderWidth = 1
        self.docImage.layer.borderColor = UIColor.appColor.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
