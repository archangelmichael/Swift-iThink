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
    var lastModified: String
    var author: String? = nil
    
    init(id: String,
         categoryID: String,
         userID: String,
         lastModified: String,
         author: String? = nil) {
        
        self.id = id
        self.categoryID = categoryID
        self.userID = userID
        self.lastModified = lastModified
        self.author = author
    }
}
