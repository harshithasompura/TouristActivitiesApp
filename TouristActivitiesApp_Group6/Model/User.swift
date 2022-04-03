import Foundation

class User {
  let emailAddress: String
  let password: String

  init(email: String, password: String) {
    self.emailAddress = email
    self.password = password
  }
}
