//
//  AddQuoteViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class AddQuoteViewController: UIViewController {
    
    @IBOutlet weak var btnSelectCategory: UIButton!
    @IBOutlet weak var tvQuote: UITextView!
    @IBOutlet weak var tfAuthor: WhiteTextField!
    @IBOutlet weak var svQuote: UIScrollView!
    
    var selectedQuote : Quote?
    var selectedQuoteCategory : QuoteCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tvQuote.setRoundCorners()
        self.tvQuote.delegate = self
        
        self.tfAuthor.setRoundCorners()
        self.tfAuthor.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
        
        self.toggleLoading(show: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    @IBAction func onSave(_ sender: Any) {
        // TODO: Save quote
        self.goBack()
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.goBack()
    }
    
    @objc func handleTap(guesture: UITapGestureRecognizer) {
        self.tfAuthor.resignFirstResponder()
        self.tvQuote.resignFirstResponder()
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
}

extension AddQuoteViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.svQuote.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.clear
    }
}

extension AddQuoteViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.svQuote.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y), animated: true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.clear
        self.svQuote.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddQuoteViewController : ModalPickerDelegate {
    func didSelectPickerItemId(item: PickerItem?) {
        self.selectedQuoteCategory = AppData.sharedInstance.getQuoteCategoryById(quoteCategoryId: item?.id)
        self.refreshSelectedCategory(quoteCategory: self.selectedQuoteCategory)
    }
}
