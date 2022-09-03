//
//  ProfileViewController.swift
//  InstaCloneFirebase
//
//  Created by Yigit on 1.09.2022.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lblUsername: UILabel!
    
    var userImageArray = [String]()
    var userNameArray = [String]()
    var url = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        
        
        
        
        getUsernameFromFirestore()
        getProfilePhotosFromFirestore()
        
        
        
     
        
          
        
        
        
    }
    

    
    func getUsernameFromFirestore(){

        let firestore = Firestore.firestore()
        firestore.collection("Users").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshot, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        if let username = document.get("username") as? String {
                            self.lblUsername.text = username
                        }


                    }

                }
            }
        }


    }
    
    func getProfilePhotosFromFirestore(){
        let firestore = Firestore.firestore()
        firestore.collection("ProfilePhotos").whereField("photoby", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshot, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                if snapshot?.isEmpty != true {
                    for document in snapshot!.documents {
                        self.url = document.get("imageUrl") as! String
                        let photoUrl = URL(string: self.url)!
                        if let data = try? Data(contentsOf: photoUrl) {
                            self.imageView.image = UIImage(data: data)
                        }
                        
                    }
                }
            }
        }
        
        
    }
    
    
    @objc func chooseImage(){
        performSegue(withIdentifier: "toProfilePhotoVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfilePhotoVC" {
            let destinationVC = segue.destination as! ChangeProfilePhotoViewController
            destinationVC.changeImageView?.image = self.imageView.image
            
        }
    }
    
  

    @IBAction func btnLogoutClicked(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toMainVC", sender: nil)
        }catch{
            print("Error")
        }
        
        
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    
}
