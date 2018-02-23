//
//  FirebaseDataParser.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

import FirebaseDatabase

class FirebaseDataParser {
    static func getUser(snapshot: DataSnapshot) -> AppUser? {
        if let userDict = snapshot.value as? Dictionary<String, AnyObject> {
            if let profile = userDict["profile"] as? Dictionary<String, AnyObject> {
                if  let name = profile["name"] as? String,
                    let email = profile["email"] as? String {
                    return AppUser(uid: snapshot.key, name: name, email: email)
                }
            }
            
            return nil
        }
        else {
            return nil
        }
    }
}
