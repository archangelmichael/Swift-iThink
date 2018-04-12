//
//  QuoteCategoryViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 12.04.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class QuoteCategoryViewController: BaseViewController, ModalPickerDelegate {

    var selectedQuoteCategory : QuoteCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func refreshSelectedCategory(quoteCategory: QuoteCategory?) { }
    
    func didSelectPickerItemId(item: PickerItem?) {
        let categorySelected = AppData.sharedInstance.getQuoteCategoryById(quoteCategoryId: item?.id)
        if let selectedCategory = categorySelected,
            selectedCategory.isCreateCategory()
        {
            self.toggleLoading()
            AppData.sharedInstance.createQuoteCategory(from: self,
                                                       success:
                { [weak self] (category) in
                    if let category = category {
                        self?.selectedQuoteCategory = category
                        self?.refreshSelectedCategory(quoteCategory: self?.selectedQuoteCategory)
                    }
                    
                    self?.toggleLoading(show: false)
                },
                                                       failure:
                { [weak self] in
                    self?.toggleLoading(show: false)
            })
        }
        else {
            self.selectedQuoteCategory = categorySelected
            self.refreshSelectedCategory(quoteCategory: self.selectedQuoteCategory)
        }
    }
}
