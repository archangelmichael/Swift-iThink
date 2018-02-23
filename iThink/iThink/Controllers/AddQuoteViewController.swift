//
//  AddQuoteViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class AddQuoteViewController: UIViewController {

    private enum QuoteState {
        case add, preview
    }
    
    @IBOutlet weak var tfAuthor: WhiteTextField!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var tvQuote: UITextView!
    @IBOutlet weak var vActions: UIStackView!
    @IBOutlet weak var vLoading: UIActivityIndicatorView!
    @IBOutlet weak var lblFooter: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    
    var selectedQuote: Quote?
    
    private var quoteState: QuoteState = .preview
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let _ = self.selectedQuote {
            self.quoteState = .preview
        }
        else {
            self.quoteState = .add
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUI()
    }
    
    func updateUI() {
        switch self.quoteState {
        case .add:
            self.lblAuthor.text = nil
            self.lblAuthor.isHidden = true
            self.tfAuthor.text = nil
            self.tfAuthor.isHidden = false
            self.tvQuote.isEditable = true
            self.btnClose.isHidden = true
            self.vActions.isHidden = false
        case .preview:
            self.lblAuthor.text = self.selectedQuote?.author
            self.lblAuthor.isHidden = false
            self.tfAuthor.text = self.selectedQuote?.text
            self.tfAuthor.isHidden = true
            self.tvQuote.isEditable = false
            self.btnClose.isHidden = false
            self.vActions.isHidden = true
        }
    }

    
    @IBAction func onAdd(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.goBack()
    }
    
    @IBAction func onClose(_ sender: Any) {
        self.goBack()
    }
}
