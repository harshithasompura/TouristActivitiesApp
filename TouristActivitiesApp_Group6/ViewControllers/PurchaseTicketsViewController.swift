import UIKit

class PurchaseTicketsViewController: UIViewController {

  //MARK: User Defaults
  var defaults: UserDefaults = UserDefaults.standard

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    print(#function, "Purchase Tickets Screen Loaded!")

    self.title = "Purchase Tickets"

    //Add signout to nav bar
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Sign Out", style: .plain, target: self, action: #selector(signOutPressed))
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

