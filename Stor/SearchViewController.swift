//
//  SecondViewController.swift
//  Stor
//
//  Created by Alex Cheng on 11/29/19.
//  Copyright © 2019 Alex Cheng. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser?.uid == nil {
            logout()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func logout() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "Login")
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true, completion: nil)
    }

}

