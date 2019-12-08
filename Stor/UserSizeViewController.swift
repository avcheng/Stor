//
//  UserSizeViewController.swift
//  Stor
//
//  Created by Alex Cheng on 12/1/19.
//  Copyright © 2019 Alex Cheng. All rights reserved.
//

import UIKit
import Firebase

class UserSizeViewController: UIViewController {

    var ref = Database.database().reference()
    
    @IBOutlet weak var textView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView.becomeFirstResponder()
    }

    @IBAction func cancelButton(_ sender: Any) {
        ref.child("storage").child(listingKey).removeValue()
        self.performSegue(withIdentifier: "sizeCancel", sender: sender)
    }
    @IBAction func nextButton(_ sender: Any) {
        let input = textView.text
        
        if input == "" {
            let alert = UIAlertController(title: "Error", message: "Please input a value", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.ref.child("storage").child(listingKey).child("size").setValue(input)
        self.performSegue(withIdentifier: "toPrice", sender: sender)
    }
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "backtoAddress", sender: sender)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if let x = string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) {
          return true
       } else {
          return false
       }
    }
}
