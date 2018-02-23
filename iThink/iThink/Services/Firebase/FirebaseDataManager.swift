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

typealias DataQuotesSuccess = ([Quote]) -> Void
typealias DataQuotesFailure = (String) -> Void

class FirebaseDataManager : NSObject {
    
    static let sharedInstance = FirebaseDataManager()
    
    private override init() { }
    
    private var dbReference: DatabaseReference {
        return Database.database().reference()
    }
    
    private var usersReference: DatabaseReference {
        return dbReference.child("users")
    }
    
    private var quotesReference: DatabaseReference {
        return dbReference.child("quotes")
    }
    
    // MARK: USERS
    
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
    
    
    
    // MARK: QUOTES
    
    func getQuotes(completion: DataQuotesSuccess?) {
        quotesReference.observe(DataEventType.value) { (snapshot) in
            let quotes = FirebaseDataParser.getQuotes(snapshot: snapshot)
            completion?(quotes)
        }
    }
    
//    func getThemeByID(themeID: String,
//                      completion: DataQuotesSuccess?) {
//        quotesReference.child(themeID).observe(DataEventType.value)
//        { (snapshot) in
//            let quote = FirebaseDataParser.getChatTheme(snapshot: snapshot)
//            completion?(quote)
//        }
//    }
//    
//    func saveQuote(name: String,
//                   author: String,
//                   authorID: String,
//                   filePath: String,
//                   failure: DataQuoteOpFailure?,
//                   success: DataQuotesSuccess?) {
//        let quote = [
//            "name" : name,
//            "author" : author,
//            "authorID" : authorID,
//            "filePath" : filePath,
//            "viewers" : [String]()
//            ] as [String : Any]
//        
//        quotesReference.childByAutoId().setValue(quote)
//        { [weak self] (error, dbRef) in
//            if let err = error {
//                failure?(err)
//            }
//            else {
//                self?.getQuoteWithRef(dbRef: dbRef, completion: success)
//            }
//        }
//    }
//    
//    func updateQuote(quote: ChatQuote,
//                     viewers: [String],
//                     failure: DataQuoteOpFailure?,
//                     success: DataQuotesSuccess?) {
//        let quoteRef = quotesReference.child(quote.uid)
//        let quoteUpdate = ["viewers" : viewers] as [String : Any]
//        quoteRef.updateChildValues(quoteUpdate)
//        { [weak self] (error, dbRef) in
//            if let err = error {
//                failure?(err)
//            }
//            else {
//                self?.getquoteWithRef(dbRef: dbRef, completion: success)
//            }
//        }
//    }
//    
//    func deleteQuote(quote: ChatQuote,
//                     failure: DataQuoteOpFailure?,
//                     success: DataQuotesSuccess?) {
//        quotesReference.child(quote.uid).removeValue
//            { [weak self]  (error, dbRef) in
//                if let err = error {
//                    failure?(err)
//                }
//                else {
//                    self?.getQuoteWithRef(dbRef: dbRef, completion: success)
//                }
//        }
//    }
//    
//    func getQuoteWithRef(dbRef: DatabaseReference,
//                         success: DataQuotesSuccess?) {
//        dbRef.observe(DataEventType.value,
//                      with:
//            { (snapshot) in
//                let quote = FirebaseDataParser.getQuote(snapshot: snapshot)
//                completion?(quote)
//        })
//    }
    
    
}
