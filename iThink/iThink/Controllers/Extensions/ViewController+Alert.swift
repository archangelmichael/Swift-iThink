//
//  ViewController+Alert.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

extension UIViewController {
    func show(title: String,
              message: String? = nil,
              callback: AlertOkCallback? = nil) {
        AlertManager.showOkAlert(from: self,
                                 title: title,
                                 message: message,
                                 callback: callback)
    }
}
