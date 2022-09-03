//
//  SignUpViewController.swift
//  InstaCloneFirebase
//
//  Created by Yigit on 1.09.2022.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var txtUsername: UITextField!
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        
        if txtEmail.text != "" && txtPassword.text != "" && txtUsername.text != "" {
            
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { authdata, error in
                if error != nil {
                    
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                    
                } else {
                    
                    let firestoreDatabase = Firestore.firestore()
                    var firestoreRef: DocumentReference
                    
                    let firestoreUser = ["username" : self.txtUsername.text! , "email" : self.txtEmail.text! , "password" : self.txtPassword.text!] as [String : Any]
                    
                    firestoreRef = firestoreDatabase.collection("Users").addDocument(data: firestoreUser, completion: { error in
                        if error != nil {
                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                        } 
                    })
                    

                    
                    self.performSegue(withIdentifier: "toMainVC", sender: nil)
                    
                }
            }
            
        } else {
            
            makeAlert(title: "Error", message: "Username, Email and Password can not be empty!")
            
        }
        
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    
   
   


  
}
