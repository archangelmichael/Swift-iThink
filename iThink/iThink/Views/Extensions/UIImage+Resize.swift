//
//  UIImage+Resize.swift
//  iThink
//
//  Created by Radi Shikerov on 25.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

extension UIImage {
    func resize(width: CGFloat,
                height: CGFloat) -> UIImage? {
        let size = self.size
        
        let widthRatio  = width  / size.width
        let heightRatio = height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio,
                             height: size.height * heightRatio)
        }
        else {
            newSize = CGSize(width: size.width * widthRatio,
                             height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0,
                          y: 0,
                          width: newSize.width,
                          height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
