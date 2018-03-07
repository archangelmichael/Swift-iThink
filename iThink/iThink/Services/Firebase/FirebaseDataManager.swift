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

typealias DataQuoteSuccess = (Quote?) -> Void
typealias DataQuotesSuccess = ([Quote]) -> Void

typealias DataQuoteCategorySuccess = (QuoteCategory?) -> Void
typealias DataQuoteCategoriesSuccess = ([QuoteCategory]) -> Void

typealias DataSuccess = () -> Void
typealias DataFailure = (String) -> Void

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
    
    private var quoteCategoriesReference: DatabaseReference {
        return dbReference.child("quoteCategories")
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
                 failure: DataFailure?) {
        usersReference.child(uid).observeSingleEvent(of: .value,
                                                     with:
            { (snapshot) in
                if let user = FirebaseDataParser.getUser(snapshot: snapshot) {
                    success?(user)
                }
                else {
                    failure?("Cannot get user profile")
                }
        })
        { (error) in
            failure?(error.localizedDescription)
        }
    }
    
    
    // MARK: QUOTES
    
    func saveQuote(categoryID: String,
                   userID: String,
                   text: String?,
                   imageUrl: String?,
                   author : String?,
                   success: DataQuoteSuccess?,
                   failure: DataFailure?) {
        if (text == nil || text!.isEmpty) && (imageUrl == nil || imageUrl!.isEmpty) {
            failure?("Invalid quote content")
            return;
        }
        
        var quote = ["categoryID" : categoryID,
                     "userID" : userID,
                     "lastModified" : Date(),
                     "author" : author ?? AppConstants.Strings.DefaultAuthor] as [String : Any]
        
        if let quoteText = text {
            quote["text"] = quoteText
        }
        else if let quoteImageUrl = imageUrl {
            quote["imageUrl"] = quoteImageUrl
        }
        
        quotesReference.childByAutoId().setValue(quote)
        { [weak self] (error, dbRef) in
            if let err = error {
                failure?(err.localizedDescription)
            }
            else {
                self?.getQuoteWithRef(dbRef: dbRef,
                                      success: success)
            }
        }
    }
    
    func getQuotes(success: DataQuotesSuccess?) {
        quotesReference.observe(DataEventType.value) { (snapshot) in
            let quotes = FirebaseDataParser.getQuotes(snapshot: snapshot)
            success?(quotes)
        }
    }
    
    func getQuoteByID(quoteID: String,
                      success: DataQuoteSuccess?) {
        quotesReference.child(quoteID).observe(DataEventType.value)
        { (snapshot) in
            let quote = FirebaseDataParser.getQuote(snapshot: snapshot)
            success?(quote)
        }
    }
    
    func updateQuote(id: String,
                     categoryID: String,
                     text: String?,
                     imageUrl: String?,
                     author : String?,
                     success: DataQuoteSuccess?,
                     failure: DataFailure?) {
        if (text == nil || text!.isEmpty) && (imageUrl == nil || imageUrl!.isEmpty) {
            failure?("Invalid quote content")
            return;
        }
        
        var quoteUpdate = ["categoryID" : categoryID,
                           "lastModified" : Date(),
                           "author" : author ?? AppConstants.Strings.DefaultAuthor] as [String : Any]
        
        if let quoteText = text {
            quoteUpdate["text"] = quoteText
        }
        else if let quoteImageUrl = imageUrl {
            quoteUpdate["imageUrl"] = quoteImageUrl
        }
        
        quotesReference.child(id).updateChildValues(quoteUpdate)
        { [weak self] (error, dbRef) in
            if let err = error {
                failure?(err.localizedDescription)
            }
            else {
                self?.getQuoteWithRef(dbRef: dbRef,
                                      success: success)
            }
        }
    }
    
    func getQuoteWithRef(dbRef: DatabaseReference,
                         success: DataQuoteSuccess?) {
        dbRef.observeSingleEvent(of: .value)
        { (snapshot) in
            let quote = FirebaseDataParser.getQuote(snapshot: snapshot)
            success?(quote)
        }
    }
    
    func deleteQuoteByID(id: String,
                         success: DataSuccess?,
                         failure: DataFailure?) {
        quotesReference.child(id).removeValue
            { (error, dbRef) in
                if let err = error {
                    failure?(err.localizedDescription)
                }
                else {
                    success?()
                }
        }
    }
    
    
    // MARK: QUOTE  CATEGORIES
    
    func saveQuoteCategory(name: String,
                           success: DataQuoteCategorySuccess?,
                           failure: DataFailure?) {
        let quoteCategory = [ "name" : name ] as [String : Any]
        
        quoteCategoriesReference.childByAutoId().setValue(quoteCategory)
        { [weak self] (error, dbRef) in
            if let err = error {
                failure?(err.localizedDescription)
            }
            else {
                self?.getQuoteCategoryWithRef(dbRef: dbRef,
                                              success: success)
            }
        }
    }
    
    func getQuoteCategories(success: DataQuoteCategoriesSuccess?) {
        quoteCategoriesReference.observe(DataEventType.value) { (snapshot) in
            let quoteCategories = FirebaseDataParser.getQuoteCategories(snapshot: snapshot)
            success?(quoteCategories)
        }
    }
    
    func getQuoteCategoryByID(categoryID: String,
                              success: DataQuoteCategorySuccess?) {
        quoteCategoriesReference.child(categoryID).observeSingleEvent(of: DataEventType.value)
        { (snapshot) in
            let quoteCategory = FirebaseDataParser.getQuoteCategory(snapshot: snapshot)
            success?(quoteCategory)
        }
    }
    
    func getQuoteCategoryWithRef(dbRef: DatabaseReference,
                                 success: DataQuoteCategorySuccess?) {
        dbRef.observeSingleEvent(of: .value)
        { (snapshot) in
            let quoteCategory = FirebaseDataParser.getQuoteCategory(snapshot: snapshot)
            success?(quoteCategory)
        }
    }
    
    func deleteQuoteCategoryByID(id: String,
                                 success: DataSuccess?,
                                 failure: DataFailure?) {
        quoteCategoriesReference.child(id).removeValue
            { (error, dbRef) in
                if let err = error {
                    failure?(err.localizedDescription)
                }
                else {
                    success?()
                }
        }
    }
}
