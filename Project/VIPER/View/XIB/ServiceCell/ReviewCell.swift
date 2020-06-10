//
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var dateLbl : UILabel!
    @IBOutlet weak var visitForLbl : UILabel!
    @IBOutlet weak var deasesLbl : UILabel!
    @IBOutlet weak var reviewLbl : UILabel!
    @IBOutlet weak var thumpsupImg : UIImageView!
    @IBOutlet weak var reviewBgView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.reviewBgView.setCorneredElevation(shadow: 1, corner: 10, color: .primary)
    }
}
