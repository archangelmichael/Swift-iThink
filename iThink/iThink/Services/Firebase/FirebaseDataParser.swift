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
    
    static func getQuotes(snapshot: DataSnapshot) -> [Quote] {
        var quotes = [Quote]()
        if let quotesDict = snapshot.value as? Dictionary<String, AnyObject> {
            for (key, value) in quotesDict {
                if let quoteDict = value as? Dictionary<String, AnyObject> {
                    if let quote = getQuote(id: key,
                                            quoteDict: quoteDict) {
                        quotes.append(quote)
                    }
                }
            }
            
            return quotes
        }
        else {
            return quotes
        }
    }
    
    
    static func getQuote(snapshot: DataSnapshot) -> Quote? {
        if let quoteDict = snapshot.value as? Dictionary<String, AnyObject> {
            return getQuote(id: snapshot.key,
                            quoteDict: quoteDict)
        }
        else {
            return nil
        }
    }

    private static func getQuote(id : String,
                                 quoteDict: Dictionary<String, AnyObject>) -> Quote? {
        if  let categoryID = quoteDict["categoryID"] as? String,
            let userID = quoteDict["userID"] as? String,
            let lastModified = quoteDict["lastModified"] as? String {
            
            let author = quoteDict["author"] as? String
            
            if let imageUrl = quoteDict["imageUrl"] as? String, imageUrl.count > 0 {
                return ImageQuote(id: id,
                                  imageUrl: imageUrl,
                                  categoryID: categoryID,
                                  userID: userID,
                                  lastModified: lastModified,
                                  author: author)
            }
            
            if let text = quoteDict["text"] as? String, text.count > 0 {
                return TextQuote(id: id,
                                 text: text,
                                 categoryID: categoryID,
                                 userID: userID,
                                 lastModified: lastModified,
                                 author: author)
            }
            
            return nil
        }
        else {
            return nil
        }
    }

    
    static func getQuoteCategories(snapshot: DataSnapshot) -> [QuoteCategory] {
        var quoteCategories = [QuoteCategory]()
        if let quoteCategoriesDict = snapshot.value as? Dictionary<String, AnyObject> {
            for (key, value) in quoteCategoriesDict {
                if let quoteCatDict = value as? Dictionary<String, AnyObject> {
                    if let quoteCtegory = getQuoteCategory(id: key,
                                                           quoteCatDict: quoteCatDict) {
                        quoteCategories.append(quoteCtegory)
                    }
                }
            }
            
            return quoteCategories
        }
        else {
            return quoteCategories
        }
    }
    
    static func getQuoteCategory(snapshot: DataSnapshot) -> QuoteCategory? {
        if let quoteCatDict = snapshot.value as? Dictionary<String, AnyObject> {
            return getQuoteCategory(id: snapshot.key,
                                    quoteCatDict: quoteCatDict)
        }
        else {
            return nil
        }
    }
    
    private static func getQuoteCategory(id : String,
                                         quoteCatDict: Dictionary<String, AnyObject>) -> QuoteCategory? {
        if  let name = quoteCatDict["name"] as? String {
            return QuoteCategory(id: id,
                                 name: name)
        }
        else {
            return nil
        }
    }
}
