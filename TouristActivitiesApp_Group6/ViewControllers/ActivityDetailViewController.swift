import UIKit
import WebKit

class ActivityDetailViewController: UIViewController, WKNavigationDelegate {

  //MARK: User Defaults
  var defaults: UserDefaults = UserDefaults.standard

  //MARK: Outlets
  @IBOutlet weak var activityTitle: UILabel!
  @IBOutlet weak var ivActivityImage: UIImageView!
  @IBOutlet weak var lblActivityDescription: UILabel!
  @IBOutlet weak var lblHostedBy: UILabel!
  @IBOutlet weak var lblActivityPrice: UILabel!
  @IBOutlet weak var webView: WKWebView!
  @IBOutlet weak var purchaseTicketButton: UIButton!

  //MARK: Data Source
  var activitiesDb = ActivityDb.shared

  //MARK: Variables

  override func viewDidLoad() {
    super.viewDidLoad()

    //config web view
    webView.navigationDelegate = self
    self.view.addSubview(webView)

    // Do any additional setup after loading the view.
    print(#function, "Activity Detail Screen Loaded!")

    self.title = "Activity Detail"

    //config activity Detail
    configureActivityDetail()

    //Add signout to nav bar
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Sign Out", style: .plain, target: self, action: #selector(signOutPressed))
  }

  override func viewDidAppear(_ animated: Bool) {
    print(#function, "Activity Detail Screen Loaded!")
  }

  //MARK: Actions
  @IBAction func purchaseTicketButtonPressed(_ sender: Any) {
    print(#function, "Purchase Ticket Button Pressed!")
  }

  @IBAction func websiteButtonPressed(_ sender: Any) {
    print(#function, "Website Button Pressed!")
    let currentActivity = activitiesDb.getActivityDetail()
    guard let url = URL(string: currentActivity.website) else {
      print("Could not find this url")
      return
    }
    webView.load(URLRequest(url: url))
    webView.frame = view.bounds
  }
  
  //MARK: Helpers/methods
  func configureActivityDetail() {
    let currentActivity = activitiesDb.getActivityDetail()
    activityTitle.text = currentActivity.name
    ivActivityImage.image = UIImage(named: currentActivity.photo)
    lblActivityDescription.text = currentActivity.description
    lblHostedBy.text = "Hosted by: " + currentActivity.hostedBy
    lblActivityPrice.text = "$" + String(currentActivity.pricingPerPerson) + "/ person"
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

