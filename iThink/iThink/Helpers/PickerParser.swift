//
//  PickerParser.swift
//  iThink
//
//  Created by Radi Shikerov on 1.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class PickerParser {
    static func getItemsFromQuoteCategories(quoteCategories: [QuoteCategory]) -> [PickerItem] {
        var items : [PickerItem] = []
        for quoteCategory in quoteCategories {
            items.append(PickerItem(id: quoteCategory.id, name: quoteCategory.name))
        }
        
        return items
    }
}
