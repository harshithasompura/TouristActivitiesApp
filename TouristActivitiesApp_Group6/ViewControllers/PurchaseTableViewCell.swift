import UIKit

class PurchaseTableViewCell: UITableViewCell {

  //MARK: Outlets
  @IBOutlet weak var lblActivityName: UILabel!
  @IBOutlet weak var lblNumberOfTickets: UILabel!
  @IBOutlet weak var lblPriceOfPurchase: UILabel!
  @IBOutlet weak var lblDateOfVisit: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}

