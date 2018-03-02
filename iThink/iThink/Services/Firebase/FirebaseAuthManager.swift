//
//  FBAuthManager.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

import FirebaseAuth

typealias AuthSuccess = (String) -> Void
typealias AuthFailure = (String) -> Void

class FirebaseAuthManager : NSObject {
    
    var isUserLogged : Bool { return Auth.auth().currentUser != nil }
    var loggedUser : User? { return Auth.auth().currentUser }
    
    static let sharedInstance = FirebaseAuthManager()
    
    private override init() { }
    
    func login(email: String,
               pass: String,
               success: AuthSuccess?,
               failure: AuthFailure?) {
        guard AppValidator.isValidEmail(email: email) else {
            failure?("Invalid email")
            return
        }
        
        guard AppValidator.isValidInput(text: pass) else {
            failure?("Invalid password")
            return
        }
        
        Auth.auth().signIn(withEmail: email,
                           password: pass)
        { (user, error) in
            if let fbUser = user {
                success?(fbUser.uid)
            }
            else {
                failure?(error!.localizedDescription)
            }
        }
    }
    
    func register(name: String,
                  email: String,
                  pass: String,
                  success: AuthSuccess?,
                  failure: AuthFailure?) {
        guard AppValidator.isValidInput(text: name) else {
            failure?("Invalid name")
            return
        }
        
        guard AppValidator.isValidEmail(email: email) else {
            failure?("Invalid email")
            return
        }
        
        guard AppValidator.isValidInput(text: pass) else {
            failure?("Invalid password")
            return
        }
        
        Auth.auth().createUser(withEmail: email,
                               password: pass)
        { (user, error) in
            if let fbUser = user {
                FirebaseDataManager.sharedInstance.saveUser(uid: fbUser.uid,
                                                            name: name,
                                                            email: email)
                success?(fbUser.uid)
            }
            else {
                failure?(error!.localizedDescription)
            }
        }
    }
    
    func logout() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        return false
    }
}
