//
//  AppUser.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class AppUser: NSObject {
    var uid: String
    var name: String
    var email: String
    
    init(uid: String,
         name: String,
         email: String) {
        self.uid = uid
        self.name = name
        self.email = email
    }
}
