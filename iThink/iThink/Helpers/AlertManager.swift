//
//  AlertManager.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

typealias AlertOkCallback = () -> Void

class AlertManager {
    static func showOkAlert(from: UIViewController,
                            title: String,
                            message: String? = nil,
                            callback: AlertOkCallback? = nil) {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
        { (action) in
            callback?()
        }
        
        alertVC.addAction(okAction)
        from.present(alertVC, animated: true, completion: nil)
    }
    
    static func  showAlertWithOptions(from: UIViewController,
                                      title: String,
                                      message: String? = nil,
                                      options: [String:((UIAlertAction) -> Void)?]) {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .actionSheet)
        for option in options {
            let action = UIAlertAction(title: option.key,
                                       style: .default,
                                       handler: option.value)
            alertVC.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(cancel)
        
        from.present(alertVC, animated: true, completion: nil)
    }
}
