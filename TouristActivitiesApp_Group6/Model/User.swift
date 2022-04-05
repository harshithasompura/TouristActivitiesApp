import Foundation

class User: Codable {
  let emailAddress: String
  let password: String

  init(email: String, password: String) {
    self.emailAddress = email
    self.password = password
  }
}
extension User: CustomStringConvertible {
  var description: String {
    return "\(self.emailAddress), \(self.password)"
  }
}
