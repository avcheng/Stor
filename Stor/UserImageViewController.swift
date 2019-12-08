//
//  UserImageViewController.swift
//  Stor
//
//  Created by Alex Cheng on 12/1/19.
//  Copyright © 2019 Alex Cheng. All rights reserved.
//

import UIKit
import Firebase

class UserImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
 {
    
    @IBOutlet weak var imageView: UIImageView!
        
    var ref = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func choosePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            
            picker.delegate = self
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
    ref.child("storage").child(listingKey).removeValue()
        self.performSegue(withIdentifier: "imageCancel", sender: sender)
    }
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "backToPrice", sender: sender)
    }
    
    var stillDefault = true
    
    @IBAction func addSpaceButton(_ sender: Any) {
        if stillDefault {
            let alert = UIAlertController(title: "Error", message: "Please pick an image", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.ref.child("storage").child(listingKey).child("completed").setValue(true)
        
        
        
        uploadPhoto(completion: { (str) in
            print(str)
        })
        
        self.performSegue(withIdentifier: "toConfirmation", sender: sender)

    }
    
    func uploadPhoto (completion:@escaping((String?) -> () )) {

        let storageRef = Storage.storage().reference().child(listingKey)
        
        if let uploadData = self.imageView.image?.jpegData(compressionQuality: 0.1) {
            storageRef.putData(uploadData, metadata: nil, completion: {
                (metadata, error) in
                
                if error != nil {
                    return
                }
                else{
                    storageRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        return
                    }
                        self.startLoading()
                        let finalURL = url?.absoluteString
                        completion(finalURL)
                        print(finalURL)
                        self.ref.child("storage").child(listingKey).child("image").setValue(finalURL)
                        
                        self.stopLoading()
                        
                    })
                }
            })
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         dismiss(animated: true, completion: nil)
         if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
             imageView.image = image
            stillDefault = false
         }
         
     }
    
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();

    func startLoading(){
        activityIndicator.center = self.view.center;
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.style = UIActivityIndicatorView.Style.gray;
        view.addSubview(activityIndicator);

        activityIndicator.startAnimating();
        self.view.isUserInteractionEnabled = false

    }

    func stopLoading(){

        activityIndicator.stopAnimating();
        self.view.isUserInteractionEnabled = true

    }
}


