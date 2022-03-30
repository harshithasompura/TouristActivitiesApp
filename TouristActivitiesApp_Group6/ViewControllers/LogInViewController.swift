//
//  ViewController.swift
//  TouristActivitiesApp_Group6
//
//  Created by som on 30/03/22.
//

import UIKit

class LogInViewController: UIViewController {
    
    //MARK: Variables
    var usersList:[User] = [] //stores users in a list
    
    //MARK: Outlets
    @IBOutlet weak var txtFieldEmailAddress: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var lblError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(#function, "Login Screen Loaded!")
        
        //clear the error label
        lblError.text = ""
        
        //creating users
        let userOne = User(email: "som", password: "123456")
        let userTwo = User(email: "tao", password: "abcdef")
        
        //add users to the list
        usersList.append(userOne)
        usersList.append(userTwo)
    }

    //MARK: Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        print(#function,"Login Button Pressed")
        
        //1. Get user email
        guard let emailFromUI = txtFieldEmailAddress.text, emailFromUI.isEmpty == false else {
            lblError.text = "Please enter a valid email"
            //before return, clear the field
            txtFieldEmailAddress.text = ""
            return
        }
        
        //2. Get password
        guard let passwordFromUI = txtFieldPassword.text, passwordFromUI.isEmpty == false else {
            lblError.text = "Please enter a valid password"
            //before return, clear the field
            txtFieldEmailAddress.text = ""
            txtFieldPassword.text = ""
            return
        }
        
        //3. Check if the user exists in our list
        lblError.text = "" // if they reached this point, they entered valid data
        
        for user in usersList {
            if user.emailAddress.contains(emailFromUI){
                //email exists in our list do stuff
                //check password
                if user.password.contains(passwordFromUI){
                    //correct password
                    //move onto next screen
                    
                } else {
                    //incorrect password
                    lblError.text = "The email/password combination does not match"
                }
            } else {
                //email does not exist in our list
                //TODO: this is not working as I expected
                lblError.text = "This email does not exist"
            }
        }
        
        
        //4. clear the input fields/error
        //lblError.text = ""
        
    }
    
}

