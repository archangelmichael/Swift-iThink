//
//  HomeViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cvQuotes: UICollectionView!
    
    @IBOutlet weak var svTabs: UIStackView!
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnFavourites: UIButton!
    
    var loggedUser : AppUser?
    var logoutUser = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblTitle.text = " "
        
        if let loggedUser = FirebaseAuthManager.sharedInstance.loggedUser {
            self.toggleLoading()
            FirebaseDataManager.sharedInstance.getUser(uid: loggedUser.uid,
                                                       success:
                { [weak self] (user) in
                    self?.updateProfileSuccess(user: user)
                },
                                                       failure:
                { [weak self] (error) in
                    self?.updateProfileError(error: error)
                    
            })
        }
        else {
            self.logoutUser = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.logoutUser {
            self.onSignOut(UIButton())
        }
        else {
            if !AppData.sharedInstance.areQuoteCategoriesLoaded {
                AppData.sharedInstance.reloadQuoteCategories(callback: { [weak self] in
                    self?.refreshQuotes()
                })
            }
        }
    }
    
    private func refreshQuotes()
    {
        
    }
    
    func updateProfileSuccess(user: AppUser) {
        self.toggleLoading(show: false)
        self.loggedUser = user
        self.lblTitle.text = "Signed in as @\(user.name)"
    }
    
    func updateProfileError(error: String?) {
        self.show(title: "Loading profile failed",
                  message: error)
        { [weak self] () in
            self?.loggedUser = nil
            self?.onSignOut(UIButton())
        }
    }
    
    @IBAction func onAll(_ sender: Any) {
        
    }
    
    @IBAction func onFavourites(_ sender: Any) {
        
    }
    
    @IBAction func onSignOut(_ sender: Any) {
        self.toggleLoading(show: false)
        
        self.loggedUser = nil
        if FirebaseAuthManager.sharedInstance.logout() {
            self.goBackFromTabVC()
        }
        else {
            self.show(title: "Logout failed")
        }
    }
    
    @IBAction func onAddQuote(_ sender: Any) {
        self.show(vc: AddQuoteViewController.self,
                  storyboard: self.storyboard)
    }
}
