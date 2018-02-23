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
    
    var loggedUser : AppUser?
    var logoutUser = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loggedUser = FirebaseAuthManager.sharedInstance.loggedUser {
            FirebaseDataManager.sharedInstance.getUser(uid: loggedUser.uid,
                                                       success:
                { [weak self] (user) in
                    self?.updateProfileSuccess(user: user)
                },
                                                       failure:
                { [weak self] (error) in
                    self?.onSignOut(UIButton())
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
        self.loggedUser = user
        self.lblTitle.text = "Signed in as \(user.name)"
    }
    
    func updateProfileError(error: Error) {
        self.loggedUser = nil
        
    }

    @IBAction func onSignOut(_ sender: Any) {
        self.loggedUser = nil
        if FirebaseAuthManager.sharedInstance.logout() {
            self.goBack()
        }
        else {
            self.show(title: "Logout failed")
        }
    }
}
