//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by Yigit on 31.08.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        

    }
    
    
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { authdata, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
            }
        }
        
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    


}

