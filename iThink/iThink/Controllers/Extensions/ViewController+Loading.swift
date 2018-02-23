//
//  ViewController+Loading.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

extension UIViewController {
    func toggleLoading(show: Bool = true) {
        if let loadingView = self.view.viewWithTag(AppConstants.Tags.LoadingView) as? UIActivityIndicatorView {
            if show {
                loadingView.startAnimating()
            }
            else {
                loadingView.stopAnimating()
            }
        }
    }
}
