//
//  TextQuote.swift
//  iThink
//
//  Created by Radi Shikerov on 7.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class TextQuote: Quote {
    var text: String
    
    init(id: String,
         text: String,
         categoryID: String,
         userID: String,
         lastModified: String,
         author: String?) {
        self.text = text
        super.init(id: id,
                   categoryID: categoryID,
                   userID: userID,
                   lastModified: lastModified,
                   author: author)
    }
}
