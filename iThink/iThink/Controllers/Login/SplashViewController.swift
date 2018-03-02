//
//  SplashViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 2.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

import FirebaseAuth

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            // change 2 to desired number of seconds
            self?.checkLogin()
        }
    }
    
    func checkLogin() {
        if FirebaseAuthManager.sharedInstance.isUserLogged {
            self.navigationController?.performSegue(withIdentifier: AppConstants.Segues.GoHome,
                                                    sender: self)
        }
        else {
            self.navigationController?.performSegue(withIdentifier: AppConstants.Segues.GoLogin,
                                                    sender: self)
        }
    }
}
