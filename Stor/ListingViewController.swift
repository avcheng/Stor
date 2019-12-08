//
//  ListingViewController.swift
//  Stor
//
//  Created by Alex Cheng on 11/30/19.
//  Copyright © 2019 Alex Cheng. All rights reserved.
//

import UIKit
import Firebase


var getAddress = ""

class ListingViewController: UIViewController {
    var spaceID: String!

    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet weak var rentButton: UIButton!
    
    @IBOutlet var imageView: UIImageView!
    
    var address = ""
    var price = ""
    var size = ""
    var rentedBy = ""
    var imageURL = ""
    var addedBy = ""
    var status = false
    
    let ref = Database.database().reference().child("storage")
    let storageRef = Storage.storage()
    let userID = Auth.auth().currentUser?.uid
    var spaceKey = ""
    
    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    
    func getSpace(address: String) {
        getAddress = address
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addressLabel.text = ""
        priceLabel.text = ""
        sizeLabel.text = ""
        
        ref.queryOrdered(byChild: "address").queryEqual(toValue: getAddress).observe(.childAdded, with: { (snapshot) in
            
            self.spaceKey = snapshot.key
            print(self.spaceKey)
            let results = snapshot.value as? [String : AnyObject]
            self.address = results?["address"] as! String

            self.price = results?["price"] as! String
            self.size = results?["size"] as! String
            self.imageURL = results?["image"] as! String
            self.status = results?["status"] as! Bool
            self.rentedBy = results?["rentedBy"] as! String
            self.addedBy = results?["addedBy"] as! String

            self.addressLabel.text = self.address
            self.priceLabel.text = "$" + self.price + "/day"
            self.sizeLabel.text = self.size + " sq. ft"
            
            

            if self.status {
                if self.rentedBy == self.userID {
                    self.rentButton.setTitle("Cancel Rent", for: UIControl.State.normal)
                    self.rentButton.isEnabled = true
                }
                else {
                    self.rentButton.setTitle("Unavailable", for: UIControl.State.normal)
                    self.rentButton.isEnabled = false
                }
            }
            else {
                if self.addedBy == self.userID {
                    self.rentButton.setTitle("Your Own Space", for: UIControl.State.normal)
                    self.rentButton.isEnabled = false
                }
                else {
                    self.rentButton.setTitle("Rent Now", for: UIControl.State.normal)
                    self.rentButton.isEnabled = true
                }
            }

            // Create a storage reference from the URL
            let imageRef = self.storageRef.reference(forURL: self.imageURL)

            imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
              if let error = error {
                print(error)
                return
              }
              else {
                let image = UIImage(data: data!)
                self.imageView.image = image
              }
            }
        })
    }

    @IBAction func toggleRent(sender: UIButton!) {
        print(status)

        print(spaceKey)
        if status {
            sender.setTitle("Rent Now", for: UIControl.State.normal)
            ref.child(spaceKey).child("status").setValue(false)
            ref.child(spaceKey).child("rentedBy").setValue("")
            status = true
        }
        else {
            sender.setTitle("Cancel Rent", for: UIControl.State.normal)
            ref.child(spaceKey).child("status").setValue(true)
            ref.child(spaceKey).child("rentedBy").setValue(userID)
            status = false
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
}


