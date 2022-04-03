import UIKit

class ActivityDetailViewController: UIViewController {
    
    //MARK: User Defaults
    var defaults:UserDefaults = UserDefaults.standard
    
    //MARK: Outlets
    @IBOutlet weak var activityTitle: UILabel!
    @IBOutlet weak var ivActivityImage: UIImageView!
    @IBOutlet weak var lblActivityDescription: UILabel!
    @IBOutlet weak var lblHostedBy: UILabel!
    @IBOutlet weak var lblActivityPrice: UILabel!
    @IBOutlet weak var lblActivityWebsite: UILabel!
    
    //MARK: Data Source
    var activitiesDb = ActivityDb.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(#function, "Activity Detail Screen Loaded!")
        
        self.title = "Activity Detail" //TODO: should replace title as the item clicked in Collection view
        
        //config activity Detail
        configureActivityDetail()
        
        //Add signout to nav bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutPressed))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(#function, "Activity Detail Screen Loaded!")
    }
    
    //MARK: Actions
    @IBAction func purchaseTicketButtonPressed(_ sender: Any) {
        print(#function, "Purchase Ticket Button Pressed!")
    }
    
    //MARK: Helpers/methods
    func configureActivityDetail(){
        let currentActivity = activitiesDb.getActivityDetail()
        activityTitle.text = currentActivity.name
        ivActivityImage.image = UIImage(named:currentActivity.photo)
        lblActivityDescription.text = currentActivity.description
        lblHostedBy.text = "Hosted by: " + currentActivity.hostedBy
        lblActivityPrice.text = "$" + String(currentActivity.pricingPerPerson) + "/ person"
        lblActivityWebsite.text = currentActivity.website //TODO: config webview
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
