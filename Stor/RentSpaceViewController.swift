//
//  FirstViewController.swift
//  Stor
//
//  Created by Alex Cheng on 11/29/19.
//  Copyright © 2019 Alex Cheng. All rights reserved.
//

import UIKit

class UserDescriptionViewController: UIViewController {

        @IBOutlet weak var textView: UITextField!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            textView.becomeFirstResponder()
        }
    
}
