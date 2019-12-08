//
//  ProfileViewController.swift
//  Stor
//
//  Created by Alex Cheng on 11/30/19.
//  Copyright © 2019 Alex Cheng. All rights reserved.
//

import UIKit
import Firebase

var notchecked = true

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let ref = Database.database().reference()
    
    
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var storageTableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser?.uid == nil {
                logout()
        }
        let userID = Auth.auth().currentUser?.uid

        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                  // Get user value
                  let value = snapshot.value as? NSDictionary
        //            print(value)
                  let email = value?["email"] as? String ?? ""
                    self.userEmail.text = email
                  }) { (error) in
                    print(error.localizedDescription)
                }
        
        if notchecked {
            fetchSpace()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storageTableView.dataSource = self
        storageTableView.delegate = self
        
    }
    
    
    var storageList = [Spaces]()
    
    func fetchSpace() {
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("storage").queryOrdered(byChild: "completed").queryEqual(toValue: true).observe(.childAdded, with: { (snapshot) in
                    let results = snapshot.value as? [String : AnyObject]
            let addedBy = results?["addedBy"] as! String?
            if (addedBy == userID) {
                let address = results?["address"]
                let size = results?["size"]
                let price = results?["price"]
                let rentedBy = results?["rentedBy"]
                let status = results?["status"] as! Bool?
                let space = Spaces(address: address as! String?, size: size as! String?, price: price as! String?, rentedBy: rentedBy as! String?, status: status)
                
                
                self.storageList.append(space)
                
            }
            DispatchQueue.main.async {
                self.storageTableView.reloadData()
            }
        })
        
        
        notchecked = false

    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storageList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileStorageSpaces", for: indexPath)
           
            let address = storageList[indexPath.row].address!
            let size = storageList[indexPath.row].size!
            let price = storageList[indexPath.row].price!
            let status = storageList[indexPath.row].status!
            
            var cellText = ""
            if status {
                cellText = cellText + "RENTED" + " -- "
            }
            cellText = cellText + address
            cellText = cellText + ", " + size
            cellText = cellText + " sq. ft, $"
            cellText = cellText + price
            
            cell.textLabel?.text = cellText

            return cell
    }
    
       @IBAction func logoutButton(_ sender: Any) {
           logout()
       }
       
       func logout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let loginViewController = storyboard.instantiateViewController(withIdentifier: "Login")
           loginViewController.modalPresentationStyle = .fullScreen
           present(loginViewController, animated: true, completion: nil)

        notchecked = true
       }

    
}

