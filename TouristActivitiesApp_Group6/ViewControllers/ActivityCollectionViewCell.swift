import UIKit

class ActivityCollectionViewCell: UICollectionViewCell {

  //MARK: Outlets
  @IBOutlet weak var activityImageView: UIImageView!
  @IBOutlet weak var lblActivityName: UILabel!
  @IBOutlet weak var lblActivityPrice: UILabel!
  @IBOutlet weak var favouriteButton: UIButton!

  //MARK: Variables
  var favOn: Bool = true
  
  //MARK: Data Source
  var activitiesDb = ActivityDb.shared
    
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
    if favOn {
      //star a button fill
      favouriteButton.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
      //add to our fav list
      let clickedActivity = activitiesDb.getAll()[favouriteButton.tag]
      activitiesDb.setFavouriteActivity(of: clickedActivity)
      favOn = !favOn
    } else {
      //unstar a button fill
      favouriteButton.setImage(UIImage.init(systemName: "star"), for: .normal)
      favOn = !favOn
      //remove from the fav list
      let clickedActivity = activitiesDb.getAll()[favouriteButton.tag]
      activitiesDb.removeFavouriteActivity(of: clickedActivity)
    }
    print(favouriteButton.tag)  //index the cell was clicked at
  }
}
