//
//  ConfirmationViewController.swift
//  Stor
//
//  Created by Alex Cheng on 12/1/19.
//  Copyright © 2019 Alex Cheng. All rights reserved.
//

import UIKit
import Firebase

class ConfirmationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    var ref = Database.database().reference()
    
    @IBAction func browseSpaces(_ sender: Any) {
        ref.child("storage").child(listingKey).child("status").setValue(false)
        ref.child("storage").child(listingKey).child("rentedBy").setValue("")

        notchecked = true
    }
    
}
