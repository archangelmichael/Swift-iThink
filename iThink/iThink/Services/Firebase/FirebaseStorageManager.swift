//
//  FirebaseStorageManager.swift
//  iThink
//
//  Created by Radi Shikerov on 12.04.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import FirebaseStorage

typealias StorageImageUploadCallback = (String?) -> Void
typealias StorageImageDownloadSuccessCallback = (UIImage) -> Void
typealias StorageImageDownloadFailureCallback = (String?) -> Void

class FirebaseStorageManager: NSObject {
    private let storage = Storage.storage()
    
    private var storageReference: StorageReference { return  storage.reference() }
    private var imagesReference: StorageReference { return  storageReference.child("images") }
    
    static let sharedInstance = FirebaseStorageManager()
    
    private override init() { }
    
    func storeImage(name: String,
                    image: UIImage?,
                    success: StorageImageUploadCallback?,
                    failure: StorageImageUploadCallback?) {
        if let image = image,
            let imageData = UIImageJPEGRepresentation(image, 1.0) {
            let imageRef = imagesReference.child("\(name).jpg")
            let _ = imageRef.putData(imageData, metadata: nil)
            { (metadata, error) in
                guard let metadata = metadata else {
                    failure?("Image upload failed")
                    return
                }
                
                if let downloadUrl = metadata.downloadURL() {
                    success?(downloadUrl.absoluteString)
                }
                else {
                    failure?("Image url is missing")
                }
            }
        }
        else {
            failure?("No image found")
        }
    }
    
    func getStoredImage(name: String,
                        success: StorageImageDownloadSuccessCallback?,
                        failure: StorageImageDownloadFailureCallback?) {
        
        let imageRef = imagesReference.child("\(name).jpg")
        
        imageRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
            if let error = error {
               failure?(error.localizedDescription)
            }
            else {
                if let imageData = data,
                    let image = UIImage(data: imageData) {
                    success?(image)
                }
                else {
                    failure?("Error converting image data after download")
                }
            }
        }
    }
}
