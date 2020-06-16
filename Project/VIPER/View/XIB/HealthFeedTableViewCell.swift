//
//  HealthFeedTableViewCell.swift
//  Mi Dokter
//
//  Created by Mithra Mohan on 17/03/20.
//  Copyright © 2020 Mithra Mohan. All rights reserved.
//

import UIKit

class HealthFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ArticleImage : UIImageView!
    @IBOutlet weak var ArticleTitle : UILabel!
    @IBOutlet weak var Articlecontent : UILabel!
    @IBOutlet weak var publishedDate : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
