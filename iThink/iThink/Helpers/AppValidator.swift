//
//  AppValidator.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class AppValidator {
    
    static func isValidInput(text: String?) -> Bool {
        guard let input = text, input.count > 3 else {
            return false
        }
        
        return true
    }
    
    static func isValidEmail(email: String?) -> Bool {
        guard let email = email, isValidInput(text: email) else {
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
}
