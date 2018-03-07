//
//  ImageQuote.swift
//  iThink
//
//  Created by Radi Shikerov on 7.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ImageQuote: Quote {
    var imageUrl: String
    
    init(id: String,
         imageUrl: String,
         categoryID: String,
         userID: String,
         lastModified: Date,
         author: String?) {
        self.imageUrl = imageUrl
        super.init(id: id,
                   categoryID: categoryID,
                   userID: userID,
                   lastModified: lastModified,
                   author: author)
    }
}
