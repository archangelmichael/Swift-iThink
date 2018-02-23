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
    
    var selectedQuote : Quote?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
}
