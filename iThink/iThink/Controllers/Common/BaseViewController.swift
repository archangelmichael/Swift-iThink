//
//  BaseViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 2.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var actionsEnabled: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func toggleUserInteractions(enable: Bool) {
        self.toggleLoading(show: !enable)
        self.actionsEnabled = enable
    }
}
