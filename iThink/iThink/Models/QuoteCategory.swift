//
//  QuoteCategory.swift
//  iThink
//
//  Created by Radi Shikerov on 24.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class QuoteCategory: NSObject {
    
    var id: String
    var name: String
    
    private static let CreateCategoryID = "0"
    private static let CreateCategoryName = "New category"
    
    init(id: String,
         name: String) {
        self.id = id
        self.name = name
    }
    
    class func getCreateCategory() -> QuoteCategory {
        return QuoteCategory(id: QuoteCategory.CreateCategoryID,
                             name: QuoteCategory.CreateCategoryName)
    }
    
    func isCreateCategory() -> Bool {
        return self.id == QuoteCategory.CreateCategoryID
    }
}
