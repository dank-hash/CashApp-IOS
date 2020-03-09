//
//  RegisterController.swift
//  CashApp
//
//  Created by Madhura Dulanja on 3/7/20.
//  Copyright © 2020 Madhura. All rights reserved.
//

import UIKit
import Firebase
class RegisterController: UIViewController {
    
    
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSylesToRegister()
        
    }
    
    func addSylesToRegister() {
        txtUserName.roundCorners([.topLeft,.topRight], radius: 10)
        txtPassword.roundCorners([.bottomLeft,.bottomRight], radius: 10)
        txtUserName.setLeftPaddingPoints(8)
        txtPassword.setLeftPaddingPoints(8)
        txtEmail.setLeftPaddingPoints(8)
        txtEmail.placeholderColor(color: UIColor.black)
        txtUserName.placeholderColor(color: UIColor.black)
        txtPassword.placeholderColor(color: UIColor.black)
        
    }
    
    @IBAction func RegisterBtnPressed(_ sender: Any) {
        handleRegister()
    }
    
    func handleRegister(){
        let alert = AlertDialog()
        guard let email = txtEmail.text, let password = txtPassword.text, let name = txtUserName.text else {
            print("Invalid Data")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (res, error) in
            if let error = error {
                print(error)
                
                alert.showAlert(title: "Error", message: "Error occured", buttonText: "Ok")
                return
            }
            guard let uid = res?.user.uid else {
                return
            }
            //successfully authenticated user
            
            //realtime database
            let ref = Database.database().reference(fromURL: "https://cashapp-6390b.firebaseio.com")
            print("database connection created")
            
            //let ref = Database.database().reference()
            let usersReference = ref.child("Users").child(uid)
            let values = ["Name": name, "Email": email]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if let err = err {
                    print(err)
                    return
                }
                
                alert.showAlert(title: "Signed up successfully", message: "You have been successfully Signed up", buttonText: "Ok")
                print("saved successfully to db")
                self.clear()
                
                
                self.dismiss(animated: true, completion: nil)
            })
            
        })
    }
    
    func clear(){
        txtEmail.text = ""
        txtUserName.text = ""
        txtPassword.text = ""
    }
    
    
    
    
}
