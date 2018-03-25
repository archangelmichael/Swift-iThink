//
//  HomeViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var cvQuotes: UICollectionView!
    
    @IBOutlet weak var vTabs: UIView!
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnFavourites: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAppearance()
        
        if let _ = FirebaseAuthManager.sharedInstance.loggedUser {
            self.toggleLoading()
            // TODO: Load quotes
            self.toggleLoading(show: false)
        }
    }
    
    func setAppearance() {
        self.vTabs.setColoredRoundedCorners()
        self.onTabSelected(self.btnAll)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = FirebaseAuthManager.sharedInstance.loggedUser {
            if !AppData.sharedInstance.areQuoteCategoriesLoaded {
                AppData.sharedInstance.reloadQuoteCategories(callback: { [weak self] in
                    self?.refreshQuotes()
                })
            }
        }
        else {
            self.logout()
        }
    }
    
    @IBAction func onTabSelected(_ sender: UIButton) {
        switch sender {
        case self.btnAll:
            self.btnAll.backgroundColor = UIColor.white
            self.btnFavourites.backgroundColor = UIColor.clear
            self.btnFavourites.isSelected = false
        case self.btnFavourites:
            self.btnFavourites.backgroundColor =  UIColor.white
            self.btnAll.backgroundColor = UIColor.clear
            self.btnAll.isSelected = false
        default: break
        }
        
        sender.isSelected = true
    }
    
    @IBAction func onAddQuote(_ sender: Any) {
        let options : [String : ((UIAlertAction)->Void)?] = [
            "Add quote with image" : { [weak self] (action) in
                self?.show(vc: AddImageQuoteViewController.self,
                            storyboard: self?.storyboard)
            },
            "Add quote with text" : { [weak self] (action) in
                self?.show(vc: AddQuoteViewController.self,
                           storyboard: self?.storyboard)
            }
        ]
        
        AlertManager.showAlertWithOptions(from: self,
                                          title: "Select option",
                                          options: options)
    }
    
    private func logout() {
        self.toggleLoading(show: false)
        FirebaseAuthManager.sharedInstance.logout { [weak self] (done) in
            done ? self?.goBackFromTabVC() : self?.show(title: "Logout failed")
            self?.toggleLoading(show: !done)
        }
    }
    
    private func refreshQuotes()
    {
        print("Quote Categories are loaded")
        self.toggleLoading(show: false)
    }
}
