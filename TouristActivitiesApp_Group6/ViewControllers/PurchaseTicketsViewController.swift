import UIKit

class PurchaseTicketsViewController: UIViewController {

  //MARK: User Defaults
  var defaults: UserDefaults = UserDefaults.standard

  //MARK: Outlets
  @IBOutlet weak var purchaseTableView: UITableView!
  @IBOutlet weak var costLabel: UILabel!

  //MARK: Data Source
  var activitiesDb = ActivityDb.shared

  //MARK: Variables

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    print(#function, "Purchase Tickets Screen Loaded!")

    self.title = "Purchase Tickets"

    //tableview config
    purchaseTableView.dataSource = self
    purchaseTableView.delegate = self
    purchaseTableView.register(
      UINib(nibName: "PurchaseTableViewCell", bundle: nil), forCellReuseIdentifier: "purchaseCell")
    purchaseTableView.rowHeight = 140

    //Add signout to nav bar
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Sign Out", style: .plain, target: self, action: #selector(signOutPressed))
  }

  override func viewWillAppear(_ animated: Bool) {
    purchaseTableView.reloadData()
    updateCost()
  }

  //MARK: Helpers/methods
  //update LBLcost
  func updateCost() {
    var cost: Double = 0
    for i in ActivityDb.shared.getAllTicketPurchase() {
      cost = cost + i.totalCostOfPurchase
    }
    costLabel.text = "Total Cost: $\(String(format: "%.2f", cost))"

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

extension PurchaseTicketsViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return activitiesDb.getPurchaseListFromUserDefaults().count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =
      purchaseTableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath)
      as! PurchaseTableViewCell

    let i = ActivityDb.shared.getAllTicketPurchase()[indexPath.row]
    cell.lblActivityName.text = "Activity: \(i.nameOfActivity)"
    cell.lblNumberOfTickets.text = "No. of tickets: \(i.quantity)"
    cell.lblPriceOfPurchase.text = "Total Cost: $\(i.totalCostOfPurchase)"
    cell.lblDateOfVisit.text = "Date of Visit: \(i.dateOfVisit)"
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Row clicked: \(indexPath.row)")
  }
  func tableView(
    _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    activitiesDb.deleteOneTicketPurchase(indexOfPurchaseToGo: indexPath.row)
    //before!
    tableView.deleteRows(at: [indexPath], with: .fade)

    updateCost()
    tableView.reloadData()
  }
}

