import UIKit

class ActivitiesViewController: UIViewController {

    //MARK: User Defaults
    var defaults:UserDefaults = UserDefaults.standard
    
    //MARK: Outlets
    @IBOutlet weak var activityCollectionView: UICollectionView!
    
    //MARK: Data Source
    var activitiesDb = ActivityDb.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(#function, "Activities Screen")
        
        self.title = "Activities"
        
        //collectionView config
        activityCollectionView.delegate = self
        activityCollectionView.dataSource = self
        activityCollectionView.register(UINib.init(nibName: "ActivityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "activityCell")
        
        //Add signout to nav bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutPressed))
        
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
        nextScreen.modalPresentationStyle = .fullScreen //changing next screen to full screen here
        
        // - navigate to the next screen
        self.present(nextScreen, animated:true, completion:nil)
    }
}

//MARK: Collection View Config
extension ActivitiesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
      }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activitiesDb.totalActivities()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = indexPath.row
        
        let clickedActivity = activitiesDb.getAll()[item]
        let cell = collectionView.dequeueReusableCell(
              withReuseIdentifier: "activityCell",
              for: indexPath) as! ActivityCollectionViewCell
        
        // Configure the cell
        cell.configure(with: clickedActivity)
        if(item == 1 || item == 4){
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
        cell.favouriteButton.tag = indexPath.row //to know which cell was clicked
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size:CGFloat = (activityCollectionView.frame.size.width - space) / 2.0
            return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedItem = indexPath.row
            print("You selected Item #\(selectedItem)")
            
            //configure activity clicked
            let clickedActivity = activitiesDb.getAll()[selectedItem]
            activitiesDb.setActivityDetail(of: clickedActivity)
            
            //Move to Activity Detail Screen here
            guard let nextScreen = storyboard?.instantiateViewController(identifier: "activityDetail") else {
                       print("Cannot find next screen")
                       return
            }
            nextScreen.modalPresentationStyle = .fullScreen //changing next screen to full screen here
            
            // - navigate to the next screen
            navigationController?.pushViewController(nextScreen, animated: true)
    }
    
}
