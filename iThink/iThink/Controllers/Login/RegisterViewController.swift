//
//  RegisterViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 2.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

import FirebaseAuth

class RegisterViewController: BaseViewController {

    @IBOutlet weak var tfName: WhiteTextField!
    @IBOutlet weak var tfEmail: WhiteTextField!
    @IBOutlet weak var tfPass: WhiteTextField!
    @IBOutlet weak var tfPassConfirm: WhiteTextField!
    
    weak var loginNavDelegate : LoginBaseNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tfName.delegate = self
        self.tfEmail.delegate = self
        self.tfPass.delegate = self
        self.tfPassConfirm.delegate = self
        
        self.toggleUserInteractions(enable: true)
    }

    @IBAction func onSignUp(_ sender: Any) {
        self.view.endEditing(true)
        
        guard actionsEnabled else {
            print("Actions disabled")
            return
        }
        
        guard let name = self.tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !name.isEmpty
            else {
            self.tfName.invalidate()
            return
        }
        
        guard let email = self.tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !email.isEmpty
            else {
            self.tfEmail.invalidate()
            return
        }
        
        guard let pass = self.tfPass.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !pass.isEmpty else {
            self.tfPass.invalidate()
            return
        }
        
        guard let passConfirmation = tfPassConfirm.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !passConfirmation.isEmpty
            else {
            tfPassConfirm.invalidate()
            return
        }
        
        self.toggleUserInteractions(enable: false)
        FirebaseAuthManager.sharedInstance.register(name: name,
                                                    email: email,
                                                    pass: pass,
                                                    success:
            { [weak self] (user) in
                self?.toggleUserInteractions(enable: true)
                self?.loginNavDelegate?.goToVC(vcType: .login)
            },
                                                    failure:
            { [weak self] (error) in
                self?.toggleUserInteractions(enable: true)
                self?.show(title: "Sign up failed",
                           message: error)
        })
    }
    
    @IBAction func onBack(_ sender: Any) {
        guard actionsEnabled else {
            return
        }
        
        self.loginNavDelegate?.goToVC(vcType: .login)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension RegisterViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.tfName: self.tfEmail.becomeFirstResponder()
        case self.tfEmail: self.tfPass.becomeFirstResponder()
        case self.tfPass: self.tfPassConfirm.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
            self.onSignUp(UIButton())
        }
        
        return true
    }
}
