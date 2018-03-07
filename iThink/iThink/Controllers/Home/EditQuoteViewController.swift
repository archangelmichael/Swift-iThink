//
//  EditQuoteViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class EditQuoteViewController: UIViewController {

    var selectedQuote : Quote!
    
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblQuote: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = self.selectedQuote as? TextQuote {
            self.lblQuote.isHidden = false
        }
        else {
            self.lblQuote.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.updateUI()
    }
    
    func updateUI() {
        self.lblCategory.text = self.selectedQuote.categoryID
        self.lblQuote.text = (self.selectedQuote as? TextQuote)?.text
        self.lblAuthor.text = "by @\(self.selectedQuote.author ?? AppConstants.Strings.DefaultAuthor)"
    }
    
    @IBAction func onEdit(_ sender: Any) {
        if let addVC = self.storyboard?.instantiateViewController(withIdentifier: AddQuoteViewController.self.defaultStoryboardIdentifier) as? AddQuoteViewController {
            addVC.selectedQuote = self.selectedQuote
            self.show(vc: addVC)
        }
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.goBack()
    }
}
