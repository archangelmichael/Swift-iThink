//
//  ViewController+Navigation.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

enum StoryboardName : String {
    case Login, Main, Common
}


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
                                    storyboardName: StoryboardName?,
                                    animated: Bool = true,
                                    completion: (() -> Void)? = nil) {
        if let name = storyboardName?.rawValue {
            let storyboard = UIStoryboard.init(name: name, bundle: nil)
            show(vc: vc,
                 storyboard: storyboard,
                 animated: animated,
                 completion: completion)
        }
        else {
            print("Invalid source storyboard name")
        }
    }
    
    func show<T : UIViewController>(vc: T.Type,
                                    storyboard: UIStoryboard?,
                                    animated: Bool = true,
                                    completion: (() -> Void)? = nil) {
        if let sourceStoryboard = storyboard {
            let nextVC = sourceStoryboard.instantiateViewController(withIdentifier: T.defaultStoryboardIdentifier)
            self.show(vc: nextVC,
                      animated: animated,
                      completion: completion)
        }
        else {
            print("Invalid source storyboard")
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
                     fromVC: UIViewController,
                     animated: Bool = true,
                     completion: (() -> Void)? = nil) {
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        fromVC.present(vc, animated: animated, completion: completion)
    }
    
    func goBack(animated: Bool = true,
                completion: (() -> Void)? = nil) {
        if let navVC = self.navigationController {
            navVC.popViewController(animated: animated)
        }
        else {
            self.dismiss(animated: animated, completion: completion)
        }
    }
    
    func goBackFromTabVC(animated: Bool = true,
                         completion: (() -> Void)? = nil) {
        if let tabBarVC = self.tabBarController {
            tabBarVC.goBack(animated: animated, completion: completion)
        }
        else {
            self.goBack(animated: animated, completion: completion)
        }
    }
}
