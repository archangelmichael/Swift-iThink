//
//  UIView+Rounded.swift
//  iThink
//
//  Created by Radi Shikerov on 28.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

extension UIView {

    func setRoundCorners(radius: CGFloat = 5.0) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func setColoredRoundedCorners(withColor color: UIColor = UIColor.white,
                                  cornerWidth: CGFloat = 1.0,
                                  radius: CGFloat = 5.0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = cornerWidth
        self.setRoundCorners(radius: radius)
    }
}
