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
                    if  let text = quoteDict["text"] as? String,
                        let creatorID = quoteDict["creatorID"] as? String,
                        let votes = quoteDict["votes"] as? Int {
                        
                        let author = quoteDict["author"] as? String
                        let date = quoteDict["date"] as? String
                        quotes.append(Quote(id: key,
                                            text: text,
                                            creatorID: creatorID,
                                            votes: votes,
                                            author: author,
                                            date: date))
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
            if  let text = quoteDict["text"] as? String,
                let creatorID = quoteDict["creatorID"] as? String,
                let votes = quoteDict["votes"] as? Int {
                
                let author = quoteDict["author"] as? String
                let date = quoteDict["date"] as? String
                
                return Quote(id: snapshot.key,
                             text: text,
                             creatorID: creatorID,
                             votes: votes,
                             author: author,
                             date: date)
            }
            
            return nil
        }
        else {
            return nil
        }
    }
}
