//
//  ViewController+Navigation.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

protocol NavigationController: class {
    static var defaultStoryboardIdentifier: String { get }
}

extension NavigationController where Self: UIViewController {
    static var defaultStoryboardIdentifier: String {
        return NSStringFromClass(self).components(separatedBy:".").last!
    }
}

extension UIViewController : NavigationController {
    
    func show<T : UIViewController>(vc: T.Type,
                                    animated: Bool = true,
                                    completion: (() -> Void)? = nil,
                                    storyboardName: String? = nil) {
        
        var sourceStoryboard : UIStoryboard? = self.storyboard
        if storyboardName != nil {
            sourceStoryboard = UIStoryboard(name: storyboardName!, bundle: Bundle.main)
        }
        
        if let nextVCStoryboard = sourceStoryboard {
            let nextVC = nextVCStoryboard.instantiateViewController(withIdentifier: T.defaultStoryboardIdentifier)
            self.show(vc: nextVC,
                      animated: animated,
                      completion: completion)
        }
        else {
            print("Invalid navigation")
        }
    }
    
    func show(vc: UIViewController,
              animated: Bool = true,
              completion: (() -> Void)? = nil) {
        if let navVC = self.navigationController {
            navVC.pushViewController(vc, animated: true)
        }
        else {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func showModally(vc: UIViewController,
                     animated: Bool = true,
                     completion: (() -> Void)? = nil)
    {
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(vc, animated: animated, completion: completion)
    }
    
    func goBack() {
        if let navVC = self.navigationController {
            navVC.popViewController(animated: true)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
