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
    @IBOutlet weak var vTabs: UISegmentedControl!
    @IBOutlet weak var cvQuotes: UICollectionView!
    
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

    @IBAction func onSignOut(_ sender: Any) {
        self.toggleLoading(show: false)
        
        self.loggedUser = nil
        if FirebaseAuthManager.sharedInstance.logout() {
            self.goBack()
        }
        else {
            self.show(title: "Logout failed")
        }
    }
    
    @IBAction func onQuote(_ sender: Any) {
        
        self.show(vc: EditQuoteViewController.self)
//        self.show(vc: AddQuoteViewController.self)
    }
}
