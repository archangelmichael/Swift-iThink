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
    
    var loggedUser : AppUser?
    var logoutUser = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAppearance()
        
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
        let options : [String : ((UIAlertAction)->Void)?] = [
            "Take image" : { [weak self] (action) in self?.openCamera() },
            "Select image" : { [weak self] (action) in self?.openImages() }
        ]
        
        AlertManager.showAlertWithOptions(from: self,
                                          title: "Select option",
                                          options: options)
        
        
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraVC = UIImagePickerController()
            cameraVC.sourceType = .camera
            cameraVC.allowsEditing = true
            cameraVC.delegate = self
            self.present(cameraVC, animated: true, completion: nil)
        }
        else {
            self.show(title: "Device camera is not available")
        }
    }
    
    func openImages() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagesVC = UIImagePickerController()
            imagesVC.sourceType = .photoLibrary
            imagesVC.allowsEditing = true
            imagesVC.delegate = self
            self.present(imagesVC, animated: true, completion: nil)
        }
        else {
            self.show(title: "Device images are not available")
        }
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

extension SettingsViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.saveAvatar(image: selectedImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
