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

    @IBAction func onSelectCategory(_ sender: Any) {
        // TODO: Implement selection and creation of category
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
