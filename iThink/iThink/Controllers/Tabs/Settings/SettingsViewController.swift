//
//  SettingsViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 19.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {

    @IBOutlet weak var lblSignedIn: UILabel!
    @IBOutlet weak var ivAvatar: UIImageView!
    
    var imagePicker : ImagePicker?
    var loggedUser : AppUser?
    var logoutUser = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAppearance()
        self.imagePicker = ImagePicker(owner: self,
                                       callback:
            { [weak self] (image) in
            self?.ivAvatar.image = image
        })
        
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
    
    func setAppearance() {
        self.lblSignedIn.text = ""
        self.ivAvatar.setColoredRoundedCorners(withColor: UIColor.white,
                                               cornerWidth: 1.0,
                                               radius: self.ivAvatar.frame.size.width/2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.logoutUser {
            self.onSignOut(UIButton())
        }
    }

    @IBAction func onSignOut(_ sender: Any) {
        self.toggleLoading(show: false)
        
        self.loggedUser = nil
        FirebaseAuthManager.sharedInstance.logout { [weak self] (done) in
            done ? self?.goBackFromTabVC() : self?.show(title: "Logout failed")
            self?.toggleLoading(show: !done)
        }
    }
    
    @IBAction func onChangeAvatar(_ sender: Any) {
        self.imagePicker?.showImageOptions()
    }
    
    func saveAvatar(image: UIImage) {
        self.ivAvatar.image = image
        // TODO: Upload image to storage and set its url in the user profile
    }
    
    private func updateProfileSuccess(user: AppUser) {
        self.toggleLoading(show: false)
        self.loggedUser = user
        self.lblSignedIn.text = "Signed in as @\(user.name)"
    }
    
    private func updateProfileError(error: String?) {
        self.show(title: "Loading profile failed",
                  message: error)
        { [weak self] () in
            self?.loggedUser = nil
            self?.onSignOut(UIButton())
        }
    }
}
