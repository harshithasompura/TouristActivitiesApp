import UIKit

class FavouritesViewController: UIViewController {

  //MARK: User Defaults
  var defaults: UserDefaults = UserDefaults.standard

  //MARK: Outlets
  @IBOutlet weak var favouriteActivityCollectionView: UICollectionView!

  //MARK: Data Source
  var activitiesDb = ActivityDb.shared

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    print(#function, "Favourites Screen Loaded!")

    self.title = "Favourites"

    //favoriteslist collectionview config
    favouriteActivityCollectionView.delegate = self
    favouriteActivityCollectionView.dataSource = self
    favouriteActivityCollectionView.register(
      UINib.init(nibName: "ActivityCollectionViewCell", bundle: nil),
      forCellWithReuseIdentifier: "activityCell")

    //Add signout to nav bar
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Sign Out", style: .plain, target: self, action: #selector(signOutPressed))
  }

  override func viewDidAppear(_ animated: Bool) {
    //reload fav list view
    favouriteActivityCollectionView.reloadData()
  }

  @objc private func signOutPressed() {
    //set remember me to false
    self.defaults.set(false, forKey: "KEY_REMEMBER_USER")

    // go to log in screen
    // - try to get a reference to the next screen
    guard let nextScreen = storyboard?.instantiateViewController(identifier: "loginScreen") else {
      print("Cannot find next screen")
      return
    }
    nextScreen.modalPresentationStyle = .fullScreen  //changing next screen to full screen here

    // - navigate to the next screen
    self.present(nextScreen, animated: true, completion: nil)
  }

}

//MARK: Collection View Config
extension FavouritesViewController: UICollectionViewDataSource, UICollectionViewDelegate,
  UICollectionViewDelegateFlowLayout
{

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int
  {
    return activitiesDb.getFavouritesList().count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell
  {
    let item = indexPath.row

    let clickedActivity = activitiesDb.getFavouritesList()[item]
    let cell =
      collectionView.dequeueReusableCell(
        withReuseIdentifier: "activityCell",
        for: indexPath) as! ActivityCollectionViewCell

    // Configure the cell
    cell.configure(with: clickedActivity)
    cell.favouriteButton.setImage(UIImage.init(systemName: "star.fill"), for: .normal)
    if item == 1 || item == 4 {
      //change color for popular activity based on index 1 and 4
      cell.layer.borderColor = UIColor.systemRed.cgColor
      cell.layer.borderWidth = 1
      cell.layer.cornerRadius = 8
      //some shadow color to the cell
      cell.layer.shadowColor = UIColor.systemRed.cgColor
      cell.layer.shadowOffset = CGSize(width: 2, height: -4)
      cell.layer.shadowRadius = 8
      cell.layer.shadowOpacity = 0.2
    } else {
      cell.layer.borderColor = UIColor.systemBlue.cgColor
      cell.layer.borderWidth = 1
      cell.layer.cornerRadius = 8
      //some shadow color to the cell
      cell.layer.shadowColor = UIColor.systemBlue.cgColor
      cell.layer.shadowOffset = CGSize(width: 2, height: -4)
      cell.layer.shadowRadius = 8
      cell.layer.shadowOpacity = 0.2
    }
    //config fav button
    cell.favouriteButton.tag = indexPath.row  //to know which cell was clicked
    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
    let space: CGFloat =
      (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0)
      + (flowayout?.sectionInset.right ?? 0.0)
    let size: CGFloat = (favouriteActivityCollectionView.frame.size.width - space) / 2.0
    return CGSize(width: size, height: size)
  }
}

