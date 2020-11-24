//
//  FilterCell.swift
//  MiDokter User
//
//  Created by Sethuram Vijayakumar on 19/11/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {
    
    @IBOutlet weak var selectImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var underlineLbl: UILabel!

    var selectCirlceImg = UIImage(systemName: "record.circle")
    var UnSelectCirlceImg = UIImage(systemName: "circle")
    
    var selectBoxImg = UIImage(systemName: "checkmark.square.fill")
    var unSelectBoxImg = UIImage(systemName: "square")

    var setBoxImageForSelection : Bool = false{
        didSet{
            selectImg.image = setBoxImageForSelection ? selectBoxImg : unSelectBoxImg
            
        }
    }
    
    var setCirlceImageForSelection : Bool = false{
        
        didSet{

        selectImg.image = setCirlceImageForSelection ? selectCirlceImg : UnSelectCirlceImg
        
        }
    }
    



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
