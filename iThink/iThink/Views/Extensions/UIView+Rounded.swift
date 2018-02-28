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
    
}
