//
//  ChatCommentCell.swift
//  Project
//
//  Created by Hari Haran on 04/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class ChatCommentCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentsView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
