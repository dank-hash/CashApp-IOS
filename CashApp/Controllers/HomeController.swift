//
//  HomeController.swift
//  CashApp
//
//  Created by Madhura Dulanja on 3/6/20.
//  Copyright © 2020 Madhura. All rights reserved.
//

import UIKit
import Firebase
class HomeController: UIViewController {
    
    @IBOutlet var lblHeader: UILabel!
    
    @IBOutlet var btnAddMonthlyAmount: UIButton!
    @IBOutlet var btnAddExtraIncome: UIButton!
    @IBOutlet var btnGoToOutgoing: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func btnLogOutPressed(_ sender: Any) {
        handleLogout()
    }
    
    @objc func handleLogout() {
        
        do
        {
            try Auth.auth().signOut()
            let alert = AlertDialog();
            alert.showAlert(title: "Success", message: "You are now logged out!", buttonText: "Ok")
            print("Logged Out Successfully")
            
            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "Login") as! LoginController
            let navController = UINavigationController(rootViewController: VC1)
            self.present(navController, animated:true, completion: nil)

            
        } catch let logoutError {
            print(logoutError)
        }
        
    }
    
}
