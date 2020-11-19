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

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.docImage.cornerRadius = self.docImage.frame.height / 2
        self.rightarrow.image = self.rightarrow.image?.withRenderingMode(.alwaysTemplate)
        self.rightarrow.tintColor = UIColor(named: "TextForegroundColor")
    }
    
    func setupView(){
        self.selectionStyle = .none
        Common.setFontWithType(to: self.docNameLbl, size: 18, type: .regular)
        Common.setFontWithType(to: self.docDegreeLbl, size: 12, type: .light)
        Common.setFontWithType(to: self.docSpecialtLbl, size: 10, type: .light)
        self.docNameLbl.text = self.docNameLbl.text?.capitalized
        self.docDegreeLbl.text = self.docNameLbl.text?.uppercased()
        self.docSpecialtLbl.text = self.docSpecialtLbl.text?.uppercased()

//        setFont(to: self.docNameLbl, isTitle: false, size: 20)
//        Common.setFont(to: self.docDegreeLbl, isTitle: false, size: 15)
//        Common.setFont(to: self.docSpecialtLbl, isTitle: false, size: 13)
        
//        self.docImage.layer.borderWidth = 1
//        self.docImage.layer.borderColor = UIColor.appColor.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
