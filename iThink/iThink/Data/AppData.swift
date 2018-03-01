//
//  AppData.swift
//  iThink
//
//  Created by Radi Shikerov on 1.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class AppData: NSObject {
    
    static let sharedInstance = AppData()

    private var _quoteCategories : [QuoteCategory]?
    
    var quoteCategories : [QuoteCategory] {
        get {
            var categories : [QuoteCategory] = [ QuoteCategory.getCreateCategory() ]
            if let loadedCategories = _quoteCategories {
                categories.append(contentsOf: loadedCategories)
            }
            
            return categories
        }
        set {
            _quoteCategories = newValue
        }
    }
    
    var areQuoteCategoriesLoaded : Bool {
        return _quoteCategories != nil
    }
    
    private override init() { }
    
    func reloadQuoteCategories(callback: (() -> Void)?) -> Void {
        FirebaseDataManager.sharedInstance.getQuoteCategories {[weak self] (categories) in
            self?.quoteCategories = categories
            callback?()
        }
    }
    
    func getQuoteCategoryById(quoteCategoryId: String?) -> QuoteCategory? {
        guard let validQuoteCategoryId = quoteCategoryId else {
            return nil
        }
        
        let quoteCategoryFound = quoteCategories.first(where: { (cat) -> Bool in  cat.id == validQuoteCategoryId })
        return quoteCategoryFound
    }
}
