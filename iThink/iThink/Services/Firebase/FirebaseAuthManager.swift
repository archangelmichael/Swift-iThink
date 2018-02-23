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
    
    func login(username: String?,
               password: String?,
               success: AuthSuccess?,
               failure: AuthFailure?) {
        
        let userCredentials = AppValidator.verifyCredentials(username: username, password: password)
        if userCredentials.areValid {
            Auth.auth().signIn(withEmail: userCredentials.email!,
                               password: userCredentials.pass!)
            { (user, error) in
                if let fbUser = user {
                    success?(fbUser.uid)
                }
                else {
                    failure?(error!.localizedDescription)
                }
            }
        }
        else {
            failure?("Invalid user credentials")
        }
    }
    
    func register(username: String?,
                  password: String?,
                  success: AuthSuccess?,
                  failure: AuthFailure?) {
        
        let userCredentials = AppValidator.verifyCredentials(username: username, password: password)
        if userCredentials.areValid {
            Auth.auth().createUser(withEmail: userCredentials.email!,
                                   password: userCredentials.pass!)
            { (user, error) in
                if let fbUser = user {
                    FirebaseDataManager.sharedInstance.saveUser(uid: fbUser.uid,
                                                                name: userCredentials.name!,
                                                                email: userCredentials.email!)
                    success?(fbUser.uid)
                }
                else {
                    failure?(error!.localizedDescription)
                }
            }
        }
        else {
            failure?("Invalid user credentials")
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
