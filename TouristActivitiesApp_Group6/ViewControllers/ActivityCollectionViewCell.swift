import UIKit

class ActivityCollectionViewCell: UICollectionViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var lblActivityName: UILabel!
    @IBOutlet weak var lblActivityPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with model: Activity) {
        activityImageView.image = UIImage(named: model.photo)
        lblActivityName.text = model.name
        lblActivityPrice.text = "$" + String(model.pricingPerPerson) + "/ person"
    }
    
    //MARK: Actions
    
    @IBAction func favouriteButtonPressed(_ sender: Any) {
        print(#function, "Favourites button pressed!")
    }
}
