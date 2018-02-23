//
//  FirebaseDataManager.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

import FirebaseDatabase

typealias DataUserSuccess = (AppUser) -> Void
typealias DataUserFailure = (String) -> Void

class FirebaseDataManager : NSObject {
    
    static let sharedInstance = FirebaseDataManager()
    
    private override init() { }
    
    private var dbReference: DatabaseReference {
        return Database.database().reference()
    }
    
    private var usersReference: DatabaseReference {
        return dbReference.child("users")
    }
    
    func saveUser(uid: String,
                  name: String,
                  email: String) {
        let profile = [
            "name" : name,
            "email" : email
        ]
        
        usersReference.child(uid).child("profile").setValue(profile)
    }
    
    func getUser(uid: String,
                 success: DataUserSuccess?,
                 failure: DataUserFailure?) {
        usersReference.child(uid).observe(.value,
                                          with:
            { (snapshot) in
                if let user = FirebaseDataParser.getUser(snapshot: snapshot) {
                    success?(user)
                }
                else {
                    failure?("Cannot get user profile")
                }
        },
                                          withCancel:
            { (error) in
                failure?(error.localizedDescription)
        })
    }
}
