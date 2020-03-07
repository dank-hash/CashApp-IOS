//
//  AlertDialog.swift
//  CashApp
//
//  Created by Madhura Dulanja on 3/6/20.
//  Copyright © 2020 Madhura. All rights reserved.
//

import Foundation
import UIKit
class AlertDialog {
    func showAlert(title: String,message: String,buttonText: String)  {
        let alert = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButton(withTitle: buttonText)
        alert.show()
    }
}
