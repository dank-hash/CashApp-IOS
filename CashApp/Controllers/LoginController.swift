//
//  LoginController.swift
//  CashApp
//
//  Created by Madhura Dulanja on 3/6/20.
//  Copyright © 2020 Madhura. All rights reserved.
//

import UIKit
import Firebase
class LoginController: UIViewController {
    
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        print("Login")
        let alert = AlertDialog();
        Auth.auth().signIn(withEmail: txtUserName.text!, password: txtPassword.text!) { (user, error) in
            if error != nil {
                print(error)
                alert.showAlert(title: "Error occured", message: "You have error with your email and password", buttonText: "Ok")
            }
            else if user != nil {
                print("Success")
                
                let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "Home") as! HomeController
                let navController = UINavigationController(rootViewController: VC1)
                self.present(navController, animated:true, completion: nil)
                
            }
        }
    }
    
    
    
}
