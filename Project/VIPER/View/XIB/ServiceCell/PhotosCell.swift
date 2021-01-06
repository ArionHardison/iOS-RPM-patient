//
//  PhotosCell.swift
//  MiDokter User
//
//  Created by Abservetech on 10/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImage : UIImageView!
    @IBOutlet weak var photoView : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.photoView.clipsToBounds = true
//        self.photoView.layer.masksToBounds = true
        DispatchQueue.main.async {
            self.photoView.layer.cornerRadius = self.photoView.frame.width/2

        }
    }
}

