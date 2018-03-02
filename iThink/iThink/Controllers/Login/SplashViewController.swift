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

    var loginNavDelegate : LoginBaseNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.checkLogin()
        }
    }
    
    private func checkLogin() {
        if FirebaseAuthManager.sharedInstance.isUserLogged {
            self.navigationController?.performSegue(withIdentifier: AppConstants.Segues.GoHome,
                                                    sender: self)
        }
        else {
            self.loginNavDelegate?.goToVC(vcType: .login)
        }
    }
}
