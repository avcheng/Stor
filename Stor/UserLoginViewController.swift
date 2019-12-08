//
//  UserLoginViewController.swift
//  Stor
//
//  Created by Alex Cheng on 12/2/19.
//  Copyright © 2019 Alex Cheng. All rights reserved.
//

import UIKit
import Firebase

class UserLoginViewController: UIViewController {

    let databaseRef = Database.database().reference(fromURL: "https://stor-a70fd.firebaseio.com/")
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = email.text else {
            print("email issue")
            return
        }
        guard let password = password.text else {
            print("password issue")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error signing in", message: "Please try again or register", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
                
                
                print(error!)
                return
            }
            self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "loggedIn", sender: sender)
        })
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let email = email.text else {
            print("email issue")
            return
        }
        guard let password = password.text else {
            print("password issue")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                let alert = UIAlertController(title: "Something went wrong", message: "Please use a longer password or check your internet connection", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
                
                print(error!)
                return
            }
            guard let uid = user?.user.uid else {
                return
            }
            let userReference = self.databaseRef.child("users").child(uid)
            let values = ["email": email, "password": password]
            
            userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    let alert = UIAlertController(title: "Sign Up Error", message: "Please try again", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    
                    print(error!)
                    return
                }
                let signInSuccessful = UIAlertController(title: "Sign Up Successful", message: "Please log in", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                signInSuccessful.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(signInSuccessful, animated: true, completion: nil)
                
            })
        })
    }
}
