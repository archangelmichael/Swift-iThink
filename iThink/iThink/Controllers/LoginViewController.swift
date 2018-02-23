//
//  LoginViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var tfUsername: WhiteTextField!
    @IBOutlet weak var tfPassword: WhiteTextField!
    
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    @IBOutlet weak var vLoading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tfUsername.delegate = self
        self.tfPassword.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if FirebaseAuthManager.sharedInstance.isUserLogged {
            self.toggleUserInteractions(enable: false)
            self.showHome()
        }
        else {
            self.toggleUserInteractions(enable: true)
        }
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        if let username = self.tfUsername.text,
            let password = self.tfPassword.text {
            
            self.toggleUserInteractions(enable: false)
            FirebaseAuthManager.sharedInstance.login(username: username,
                                                     password: password,
                                                     success:
                { [weak self] (userID) in
                    self?.showHome()
            },
                                                     failure:
                { [weak self] (error) in
                    self?.toggleUserInteractions(enable: true)
                    self?.show(title: "Sign in failed",
                               message: error)
            })
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        if let username = self.tfUsername.text,
            let password = self.tfPassword.text {
            
            self.toggleUserInteractions(enable: false)
            FirebaseAuthManager.sharedInstance.register(username: username,
                                                        password: password,
                                                        success:
                { [weak self] (user) in
                    self?.showHome()
                },
                                                        failure:
                { [weak self] (error) in
                    self?.toggleUserInteractions(enable: true)
                    self?.show(title: "Sign up failed",
                               message: error)
            })
        }
    }
    
    func showHome() {
        self.toggleUserInteractions(enable: true)
        if let homeVC = self.storyboard?.instantiateViewController(withIdentifier: HomeViewController.self.defaultStoryboardIdentifier) as? HomeViewController {
            self.show(vc: homeVC)
        }
        else {
            self.show(title: "Application error",
                      message: "Profile not found")
        }
    }
    
    func toggleUserInteractions(enable: Bool) {
        if enable {
            self.vLoading.stopAnimating()
        }
        else {
            self.vLoading.startAnimating()
        }
        
        self.btnSignIn.isEnabled = enable
        self.btnSignUp.isEnabled = enable
    }
    
    @objc func handleTap(guesture: UITapGestureRecognizer) {
        self.tfUsername.resignFirstResponder()
        self.tfPassword.resignFirstResponder()
    }
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.tfUsername {
            self.tfPassword.becomeFirstResponder()
        }
        else {
            self.tfPassword.resignFirstResponder()
            self.onSignIn(UIButton())
        }
        
        return true
    }
}
