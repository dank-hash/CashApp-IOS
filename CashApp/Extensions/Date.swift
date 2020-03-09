//
//  Date.swift
//  CashApp
//
//  Created by Madhura Dulanja on 3/7/20.
//  Copyright © 2020 Madhura. All rights reserved.
//

import UIKit
extension Date {
    func toMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
