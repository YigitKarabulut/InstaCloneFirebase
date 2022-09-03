//
//  ChangeProfilePhotoViewController.swift
//  InstaCloneFirebase
//
//  Created by Yigit on 2.09.2022.
//

import UIKit
import Firebase
import FirebaseStorage
class ChangeProfilePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var changeImageView: UIImageView!
    
    var choosenImage = UIImage()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        changeImageView.addGestureRecognizer(gestureRecognizer)
        
        
        
    }
    
    
    @objc func chooseImage(){
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
        
      
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        changeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    

    @IBAction func btnOkClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("ProfilePhotos")
        
        if let data = changeImageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpg")
            imageRef.putData(data) { metadata, error in
                if error != nil {
                    
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    imageRef.downloadURL { url, error in
                        if error != nil {
                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                        } else {
                            let imageUrl = url?.absoluteString
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreRef : DocumentReference
                            let firestoreProfilePhotos = ["photoby" : Auth.auth().currentUser?.email!, "imageUrl" : imageUrl!] as [String : Any]
                            
                            if self.changeImageView.image == UIImage(systemName: "person.fill.viewfinder"){
                                
                                firestoreRef = firestoreDatabase.collection("ProfilePhotos").addDocument(data: firestoreProfilePhotos, completion: { error in
                                                              if error != nil {
                                                                  self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                                                  
                                                              } else {
                                                                  self.choosenImage = self.changeImageView.image!
                                                                  self.performSegue(withIdentifier: "toTabBarProfileVC", sender: nil)
                                                                  
                                                              }
                                                          })
                            }
                          
                            
                            
                        
                        }
                    }
                }
                
            }
            
        }
    
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTabBarProfileVC"{
            let destinationVC = segue.destination as! UITabBarController
            destinationVC.selectedIndex = 2
            let profile = destinationVC.viewControllers?.last as! ProfileViewController
            profile.imageView.image = choosenImage
        }
    }
    
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
  
    
}
