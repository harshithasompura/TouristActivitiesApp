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
  var ticketNumber = 1
  var date: String = ""

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
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2

    let subViewController = UIViewController()  //adding a subview to display pickerview
    subViewController.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)

    let pickerView = UIPickerView(
      frame: CGRect(x: 0, y: 10, width: screenWidth, height: screenHeight / 2))
    subViewController.view.addSubview(pickerView)

    pickerView.dataSource = self
    pickerView.delegate = self

    // Creating a datePicker for selecting travel date
    let datePicker: UIDatePicker = UIDatePicker()
    datePicker.frame = CGRect(x: -150, y: 200, width: screenWidth, height: screenHeight / 2)

    //Set Mode for Picker since we only want date
    datePicker.datePickerMode = .date
    let today = Date()
    //setting a future date of 3 days difference from today
    let nextDate = Calendar.current.date(byAdding: .day, value: 3, to: today)
    datePicker.minimumDate = nextDate

    subViewController.view.addSubview(datePicker)

    let alert = UIAlertController(
      title: "Select the number of tickets and date of travel", message: "",
      preferredStyle: .actionSheet)

    alert.popoverPresentationController?.sourceView = purchaseTicketButton
    alert.popoverPresentationController?.sourceRect = purchaseTicketButton.bounds

    alert.setValue(subViewController, forKey: "contentViewController")
    alert.addAction(
      UIAlertAction(
        title: "Cancel", style: .cancel,
        handler: { (UIAlertAction) in
        }))
    alert.addAction(
      UIAlertAction(
        title: "Select", style: .default,
        handler: { (UIAlertAction) in
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd"
          self.date = formatter.string(from: datePicker.date)
          print("Date of travel #\(self.date)")
          //creating the ticket purchase
          let currentActivity = self.activitiesDb.getActivityDetail()
          let nameOfTour: String = currentActivity.name
          let price: Double = currentActivity.pricingPerPerson
          let ticketPurchase = TicketPurchase(
            nameOfActivity: nameOfTour, quantity: self.ticketNumber, price: price,
            dateOfVisit: self.date)
          self.activitiesDb.addNewTicketPurchase(newPurchase: ticketPurchase)

          print(#function, "ticket purchase added: \(ticketPurchase)")

          self.showAlert()
        }))

    self.present(alert, animated: true, completion: nil)
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

  func showAlert() {
    let currentPurchaseActivityName = activitiesDb.getActivityDetail().name
    let currentTicketPurchase = activitiesDb.getAllTicketPurchase().first {
      $0.nameOfActivity == currentPurchaseActivityName
    }
    let costToDisplay: String =
      "$ " + String(format: "%.2f", currentTicketPurchase!.totalCostOfPurchase)
    print(#function, "cost is: \(costToDisplay)")
    let alert = UIAlertController(
      title: "Total cost of your purchase: ", message: costToDisplay, preferredStyle: .alert)
    alert.addAction(
      UIAlertAction(title: "Ok", style: .default, handler: { ACTION in print("ok tapped") }))
    present(alert, animated: true)
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

extension ActivityDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return activitiesDb.getTicketNumberRange().count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
    -> String?
  {
    //Updated code to show the current item in the data source
    return String(activitiesDb.getTicketNumberRange()[row])
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    ticketNumber = row + 1
    print(#function, "ticket number is \(ticketNumber)")
  }
}

