//
//  AddMonthlyIncomeController.swift
//  CashApp
//
//  Created by Madhura Dulanja on 3/7/20.
//  Copyright © 2020 Madhura. All rights reserved.
//

import UIKit
import Firebase
class AddMonthlyIncomeController: UIViewController {
    
    
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var txtCurrentAmount: UITextField!
    @IBOutlet var txtNewIncome: UITextField!
    @IBOutlet var lblNewIncome: UILabel!
    @IBOutlet var lblCurrentAmount: UILabel!
    @IBOutlet var lblBalance: UILabel!
    @IBOutlet var lblDisplayBalance: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var txtDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSylesForm()
        lblDisplayBalance.text = "0"
        txtCurrentAmount.text = "0"
        fetchAmount()
        
        self.txtNewIncome.addTarget(self, action: #selector(txtNewIncomeFieldDidChange(_:)), for: UIControl.Event.editingChanged)

    }
    
    @objc func txtNewIncomeFieldDidChange(_ textField: UITextField) {
        let txtCurrentAmount1 = txtCurrentAmount.text as! Double ?? 0
        let txtNewIncome1 = txtNewIncome.text as! Double ?? 0
        let value = txtCurrentAmount1 + txtNewIncome1
        lblDisplayBalance.text = value as! String
    }
    
    func addSylesForm() {
        txtCurrentAmount.setLeftPaddingPoints(8)
        txtNewIncome.setLeftPaddingPoints(8)
        txtDescription.setLeftPaddingPoints(8)
        txtCurrentAmount.placeholderColor(color: UIColor.black)
        txtNewIncome.placeholderColor(color: UIColor.black)
        txtDescription.placeholderColor(color: UIColor.black)
        
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        handleCreateRecord()
    }
    
    func clearFields(){
        txtNewIncome.text = ""
        txtDescription.text = ""
    }
    
    
    func handleCreateRecord(){
        let alert = AlertDialog()
        guard let NewIncome = txtNewIncome.text, let Description = txtDescription.text else {
            print("Invalid Data")
            return
        }
        
        let ref = Database.database().reference(fromURL: "https://cashapp-6390b.firebaseio.com")
        print("database connection created")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let currentTime = Date().toMillis()
        let currentTimeString: String = String(currentTime)
        print(currentTimeString)
        
        var UID = Auth.auth().currentUser?.uid as? String
        let usersReference = ref.child("Cash").child(currentTimeString)
        
        let values = ["Amount": NewIncome, "Description": Description,  "Date": currentTimeString, "UserID": UID!, "UID": UID, "CurrentDateTimeString": currentTimeString]
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if let err = err {
                print(err)
                return
            }
            
            alert.showAlert(title: "Record Created Successfully", message: "You Have Added an Amount", buttonText: "Ok")
            print("saved successfully to db")
            self.clearFields()
            
        })
        
    }
    
    func fetchAmount() {
        
        txtCurrentAmount.text = "2000"
        lblDisplayBalance.text = "2000"
        
        Database.database().reference().child("Cash").child("m712n9rR8laIvm0qhkURHX8fC8J2").observeSingleEvent(of: .value, with: { (snapshot) in
            var CurrentAmount:Double = 0
            var value:String = "0"
            if let dictionary = snapshot.value as? [String: AnyObject] {
                //self.bottomNavigationTitle.title = dictionary["Name"] as? String
                
                self.txtDescription.text = dictionary["Description"] as? String
                self.txtCurrentAmount.text = dictionary["Amount"] as? String
                
                value = dictionary["Amount"] as! String
                //let an = Double(value)
                CurrentAmount += (value as NSString).doubleValue
            }
            print(CurrentAmount)
        }, withCancel: nil)
        
    }
    
}
