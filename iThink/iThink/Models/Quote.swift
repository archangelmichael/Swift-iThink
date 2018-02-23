//
//  Thought.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class Quote: NSObject {
    var id: String
    var categoryID: String
    var userID: String
    var text: String
    var lastModified: Date
    var author: String? = nil
    
    init(id: String,
         categoryID: String,
         userID: String,
         text: String,
         lastModified: Date,
         author: String? = nil) {
        
        self.id = id
        self.categoryID = categoryID
        self.userID = userID
        self.text = text
        self.lastModified = lastModified
        self.author = author
    }
}
