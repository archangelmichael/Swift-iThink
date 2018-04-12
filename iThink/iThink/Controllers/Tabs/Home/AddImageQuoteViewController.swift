//
//  AddImageQuoteViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 7.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class AddImageQuoteViewController: QuoteCategoryViewController {

    @IBOutlet weak var btnSelectCategory: UIButton!
    @IBOutlet weak var btnAddQuote: UIButton!
    @IBOutlet weak var ivQuote: UIImageView!
    @IBOutlet weak var btnRemoveQuote: UIButton!
    
    var selectedQuoteImageUrl : String?
    var imagePicker: ImagePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(owner: self,
                                       callback:
            { [weak self] (image) in
                if let image = image {
                    self?.ivQuote.image = image
                    self?.toggleImageSelection(show: false)
                }
                else {
                    self?.toggleImageSelection(show: true)
                }
        })
        
        self.toggleUserInteractions(enable: true)
        self.btnRemoveQuote.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        self.ivQuote.setRoundCorners()
        self.toggleImageSelection(show: true)
    }
    
    @IBAction func onAddImage(_ sender: Any) {
        self.imagePicker?.showImageOptions()
    }
    
    @IBAction func onClearImage(_ sender: Any) {
        self.ivQuote.image = nil
        self.toggleImageSelection(show: true)
    }
    
    @IBAction func onSelectCategory(_ sender: Any) {
        let allCategories = AppData.sharedInstance.quoteCategories
        let pickerItems = PickerParser.getItemsFromQuoteCategories(quoteCategories: allCategories)
        if
            let tabBarVC = self.tabBarController,
            let modalVC = ModalPickerViewController.getInstance(items: pickerItems,
                                                                selectedItem: nil,
                                                                delegate: self) {
            self.showModally(vc: modalVC,
                             fromVC: tabBarVC)
        }
        else {
            self.show(title: "Application error",
                      message: "Bad navigation")
        }
    }
    
    internal override func refreshSelectedCategory(quoteCategory: QuoteCategory?) {
        if let quoteCategory = selectedQuoteCategory {
            self.btnSelectCategory.setTitle(quoteCategory.name,
                                            for: UIControlState.normal)
        }
        else {
            self.btnSelectCategory.setTitle(AppConstants.Strings.NoCategorySelected,
                                            for: UIControlState.normal)
        }
    }
    
    @IBAction func onSave(_ sender: Any) {
        guard let selectedImage = self.ivQuote.image else {
            self.show(title: "Please select image with quote")
            return
        }
        
        guard let selectedCategory = self.selectedQuoteCategory else {
            self.show(title: "Please select category")
            return
        }
        
        // TODO: Upload selected image
        // TODO: Create the quote or delete the uploaded image
        // self.goBack()
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.goBack()
    }
    
    func toggleImageSelection(show: Bool) {
        self.ivQuote.isHidden = show
        self.btnRemoveQuote.isHidden = self.ivQuote.isHidden
        self.btnAddQuote.isHidden = !self.ivQuote.isHidden
    }
}
