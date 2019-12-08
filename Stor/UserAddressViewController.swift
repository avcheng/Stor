//
//  UserAddressViewController.swift
//  Stor
//
//  Created by Alex Cheng on 12/1/19.
//  Copyright © 2019 Alex Cheng. All rights reserved.
//

import UIKit
import Firebase

var listingKey = ""


class UserAddressViewController: UIViewController {

    @IBOutlet weak var textView: UITextField!
    
    var example = UserLoginViewController()
    
    var ref = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
        
        if Auth.auth().currentUser?.uid == nil {
            logout()
        }

    }
    
    func logout() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "Login")
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true, completion: nil)
    }
    

    @IBAction func nextButton(_ sender: Any) {
        let userID = Auth.auth().currentUser?.uid
        let input = textView.text
        
        if input == "" {
            let alert = UIAlertController(title: "Error", message: "Please input a value", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
        listingKey = self.ref.child("storage").childByAutoId().key!
        self.ref.child("storage").child(listingKey).child("address").setValue(input)
        self.ref.child("storage").child(listingKey).child("addedBy").setValue(userID)
        self.ref.child("storage").child(listingKey).child("completed").setValue(false)

        self.performSegue(withIdentifier: "toSize", sender: sender)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
//        ref.child("storage").child(listingKey).removeValue()
        self.performSegue(withIdentifier: "addressCancel", sender: sender)
    }
}
