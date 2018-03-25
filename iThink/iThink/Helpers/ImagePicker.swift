//
//  ImagePickerDelegate.swift
//  iThink
//
//  Created by Radi Shikerov on 25.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

protocol ImagePickerDelegate : class {
    func didSelectImage(image: UIImage?)
}

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var owner: UIViewController!
    var successCallback: ((UIImage?) -> Void)?
    
    init(owner: UIViewController,
         callback: ((UIImage?) -> Void)?) {
        self.owner = owner
        self.successCallback = callback
    }
    
    func showImageOptions() {
        let options : [String : ((UIAlertAction)->Void)?] = [
            "Take image" : { [weak self] (action) in self?.openCamera() },
            "Select image" : { [weak self] (action) in self?.openImages() }
        ]
        
        AlertManager.showAlertWithOptions(from: self.owner,
                                          title: "Select option",
                                          options: options)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraVC = UIImagePickerController()
            cameraVC.sourceType = .camera
            cameraVC.allowsEditing = true
            cameraVC.delegate = self
            self.owner.present(cameraVC, animated: true, completion: nil)
        }
        else {
            self.owner.show(title: "Device camera is not available")
        }
    }
    
    func openImages() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagesVC = UIImagePickerController()
            imagesVC.sourceType = .photoLibrary
            imagesVC.allowsEditing = true
            imagesVC.delegate = self
            self.owner.present(imagesVC, animated: true, completion: nil)
        }
        else {
            self.owner.show(title: "Device images are not available")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
        self.successCallback?(selectedImage)
    }
}
