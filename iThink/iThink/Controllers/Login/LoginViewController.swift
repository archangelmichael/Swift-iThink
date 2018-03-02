//
//  LoginViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

import FirebaseAuth

class LoginViewController: BaseViewController {

    @IBOutlet weak var tfEmail: WhiteTextField!
    @IBOutlet weak var tfPass: WhiteTextField!
    
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tfEmail.delegate = self
        self.tfPass.delegate = self
        self.toggleUserInteractions(enable: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if FirebaseAuthManager.sharedInstance.isUserLogged {
            self.showHome()
        }
        else {
            self.toggleUserInteractions(enable: true)
        }
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        self.view.endEditing(true)
        
        guard actionsEnabled else {
            print("Actions disabled")
            return;
        }
        
        guard let email = self.tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !email.isEmpty else {
            self.tfEmail.invalidate()
            return
        }
        
        guard let pass = self.tfPass.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !pass.isEmpty
            else {
            self.tfPass.invalidate()
            return
        }
        
        self.toggleUserInteractions(enable: false)
        FirebaseAuthManager.sharedInstance.login(email:email,
                                                 pass:pass,
                                                 success:
            { [weak self] (userId) in
                self?.toggleUserInteractions(enable: true)
                self?.navigationController?.performSegue(withIdentifier: AppConstants.Segues.GoHome,
                                                         sender: self)
            },
                                                 failure:
            { [weak self] (error) in
                self?.toggleUserInteractions(enable: true)
                self?.show(title: "Sign in failed",
                           message: error)
        })
    }
    
    func showHome() {
        self.toggleUserInteractions(enable: true)
        self.navigationController?.performSegue(withIdentifier: AppConstants.Segues.GoHome,
                                               sender: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.tfEmail:
            self.tfPass.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
            self.onSignIn(UIButton())
        }
        
        return true
    }
}
