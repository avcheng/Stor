//
//  ListingListViewController.swift
//  Stor
//
//  Created by Alex Cheng on 11/30/19.
//  Copyright © 2019 Alex Cheng. All rights reserved.
//

import UIKit
import Firebase

class Spaces {
    var address: String?
    var size: String?
    var price: String?
    var status: Bool?
    var rentedBy: String?

    init(address: String?, size: String?, price: String?, rentedBy: String?, status: Bool?) {
        self.address = address
        self.size = size
        self.price = price
        self.rentedBy = rentedBy
        self.status = status
    }
}


class ListingListViewController: UITableViewController {

    
    @IBOutlet weak var storageTableView: UITableView!

    var storageList = [Spaces]()
    let ref = Database.database().reference()

    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser?.uid == nil {
            logout()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        storageTableView.dataSource = self
        storageTableView.delegate = self
        fetchSpace()
    }
    
    func fetchSpace() {
        
        ref.child("storage").queryOrdered(byChild: "completed").queryEqual(toValue: true).observe(.childAdded, with: { (snapshot) in
                    let results = snapshot.value as? [String : AnyObject]
                    let address = results?["address"]
                    let size = results?["size"]
                    let price = results?["price"]
                    let status = results?["status"]
                    let rentedBy = results?["rentedBy"]
            let space = Spaces(address: address as! String?, size: size as! String?, price: price as! String?, rentedBy: rentedBy as! String?, status: status as! Bool?)
                    self.storageList.append(space)
                    DispatchQueue.main.async {
                        self.storageTableView.reloadData()
                    }
            })

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storageList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath)
        
        let address = storageList[indexPath.row].address!
        let size = storageList[indexPath.row].size!
        let price = storageList[indexPath.row].price!
        let status = storageList[indexPath.row].status!
        
        var cellText = address + ", "
        cellText = cellText + size
        cellText = cellText + " sq. ft, $"
        cellText = cellText + price
        
        
        cell.textLabel?.text = cellText
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let space = storageList[indexPath.row]
        ListingViewController().getSpace(address: space.address!)
    }
    
    func logout() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "Login")
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true, completion: nil)
    }

}
