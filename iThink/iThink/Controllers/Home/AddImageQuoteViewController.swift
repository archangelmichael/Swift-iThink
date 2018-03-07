//
//  AddImageQuoteViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 7.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class AddImageQuoteViewController: UIViewController {

    @IBOutlet weak var btnSelectCategory: UIButton!
    @IBOutlet weak var svOptions: UIStackView!
    @IBOutlet weak var vQuote: UIView!
    @IBOutlet weak var ivQuote: UIImageView!
    @IBOutlet weak var btnRemoveQuote: UIButton!
    
    var selectedQuoteCategory : QuoteCategory?
    var selectedQuoteImageUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnRemoveQuote.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        self.ivQuote.setRoundCorners()
        self.svOptions.isHidden = false
        self.vQuote.isHidden = true
    }

    @IBAction func onSelectImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let pickerVC = UIImagePickerController()
            pickerVC.delegate = self
            pickerVC.sourceType = UIImagePickerControllerSourceType.photoLibrary
            pickerVC.allowsEditing = true
            self.present(pickerVC, animated: true, completion: nil)
        }
        else {
            self.show(title: "Images are restricted")
        }
    }
    
    @IBAction func onTakeImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let pickerVC = UIImagePickerController()
            pickerVC.delegate = self
            pickerVC.sourceType = UIImagePickerControllerSourceType.camera
            pickerVC.allowsEditing = true
            self.present(pickerVC, animated: true, completion: nil)
        }
        else {
            self.show(title: "Device has no camera")
        }
    }
    
    @IBAction func onClearImage(_ sender: Any) {
        self.svOptions.isHidden = false
        self.vQuote.isHidden = true
        self.ivQuote.image = nil
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
    
    private func refreshSelectedCategory(quoteCategory: QuoteCategory?) {
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
}

extension AddImageQuoteViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        self.ivQuote.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.vQuote.isHidden = false
        self.svOptions.isHidden = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.vQuote.isHidden = true
        self.ivQuote.image = nil
        self.svOptions.isHidden = false
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddImageQuoteViewController : ModalPickerDelegate {
    func didSelectPickerItemId(item: PickerItem?) {
        self.selectedQuoteCategory = AppData.sharedInstance.getQuoteCategoryById(quoteCategoryId: item?.id)
        self.refreshSelectedCategory(quoteCategory: self.selectedQuoteCategory)
    }
}
