import Foundation

class TicketPurchase {
  private let nameOfActivity: String
  private let quantity: Int
  private let price: Double
  private let dateOfVisit: String

  init(nameOfActivity: String, quantity: Int, price: Double, dateOfVisit: String) {
    self.nameOfActivity = nameOfActivity
    self.dateOfVisit = dateOfVisit
    self.quantity = quantity
    self.price = price
  }

  func getOnePurchaseCost() -> Double {
    return self.price * Double(self.quantity)
  }
}

extension TicketPurchase: CustomStringConvertible {
  var description: String {
    return "\(self.nameOfActivity),  $\(self.price)*\(self.quantity), \(self.dateOfVisit)"
  }
}

