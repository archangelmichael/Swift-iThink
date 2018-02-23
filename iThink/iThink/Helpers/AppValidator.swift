//
//  AppValidator.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class AppValidator {
    
    static func verifyCredentials(username: String?,
                                  password: String?) -> (areValid: Bool, name: String?, email: String?, pass: String?) {
        guard
            let name = username?.trimmingCharacters(in: .whitespacesAndNewlines),
            let pass = password?.trimmingCharacters(in: .whitespacesAndNewlines),
            name.count > 3,
            pass.count > 3
            else {
                return (areValid: false,
                        name: nil,
                        email: nil,
                        pass: nil)
        }
        
        return (areValid: true,
                name: name,
                email: "\(name)@abv.bg",
                pass: pass)
    }
}
