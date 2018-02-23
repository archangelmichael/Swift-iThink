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
    var text: String
    var creatorID: String
    var votes: Int = 0
    var author: String? = nil
    var date: String? = nil
    
    init(id: String,
         text: String,
         creatorID: String,
         votes: Int = 0,
         author: String?,
         date: String?) {
        self.id = id
        self.text = text
        self.creatorID = creatorID
        self.votes = votes
        self.author = author
        self.date = date
    }
}
