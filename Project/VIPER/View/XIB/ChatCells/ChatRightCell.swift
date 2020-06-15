//
//  ChatRightCell.swift
//  MiDokter User
//
//  Created by AppleMac on 13/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class ChatRightCell: UITableViewCell {
    
    @IBOutlet weak var msgLbl : UILabel!
    @IBOutlet weak var timeLbl : UILabel!
    @IBOutlet weak var tickImage : UIImageView!
    @IBOutlet weak var msgBGView : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        msgBGView.setCorneredElevation(shadow: 1, corner: 10, color: UIColor.clear)
        Common.setFont(to: self.msgLbl, isTitle: false, size: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}


class ChatLeftCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
