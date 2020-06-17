//
//

import UIKit

class ServiceSpecializationCell: UITableViewCell {

    @IBOutlet weak var serviceLbl : UILabel!
    @IBOutlet weak var dotImg : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setTextFonts()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    private func setTextFonts() {
           Common.setFont(to: serviceLbl)
    }
    
}
