//
//  LoginBaseViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 2.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

enum LoginVCType {
    case splash, login, register
}

protocol LoginBaseNavigationDelegate {
    func goToVC(vcType: LoginVCType)
}

class LoginBaseViewController: UIViewController {

    @IBOutlet weak var ivBackground: UIImageView!
    @IBOutlet weak var vContainer: UIView!
    
    @IBOutlet weak var cstrLeadingBackground: NSLayoutConstraint!
    
    private let BackgroundAnimationDuration = 14.0
    
    private lazy var splashVC: SplashViewController = {
        let storyboard = UIStoryboard(name: StoryboardName.Login.rawValue,
                                      bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: SplashViewController.self.defaultStoryboardIdentifier) as! SplashViewController
        self.add(asChildViewController: vc)
        vc.loginNavDelegate = self
        return vc
    }()
    
    private lazy var loginVC: LoginViewController = {
        let storyboard = UIStoryboard(name: StoryboardName.Login.rawValue,
                                      bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: LoginViewController.self.defaultStoryboardIdentifier) as! LoginViewController
        self.add(asChildViewController: vc)
        vc.loginNavDelegate = self
        return vc
    }()
    
    private lazy var registerVC: RegisterViewController = {
        let storyboard = UIStoryboard(name: StoryboardName.Login.rawValue,
                                      bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: RegisterViewController.self.defaultStoryboardIdentifier) as! RegisterViewController
        self.add(asChildViewController: vc)
        vc.loginNavDelegate = self
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.add(asChildViewController: splashVC)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.animateBackground()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)

        // Add Child View as Subview
        view.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    private func animateBackground() {
        self.view.layoutIfNeeded()
        self.moveBGRight()
    }

    private func moveBGLeft() {
        self.cstrLeadingBackground.constant = -self.view.bounds.width

        UIView.animate(withDuration: BackgroundAnimationDuration,
                       animations: {
                        self.view.layoutIfNeeded()
        }) { (complete) in
            if complete {
                self.moveBGRight()
            }
        }
    }

    private func moveBGRight() {
        self.cstrLeadingBackground.constant = 0
        UIView.animate(withDuration: BackgroundAnimationDuration,
                       animations:
            {
                self.view.layoutIfNeeded()
        })
        { (complete) in
            if complete {
                self.moveBGLeft()
            }
        }
    }
}

extension LoginBaseViewController : LoginBaseNavigationDelegate {
    func goToVC(vcType: LoginVCType) {
        switch vcType {
        case .splash:
            remove(asChildViewController: loginVC)
            remove(asChildViewController: registerVC)
            add(asChildViewController: splashVC)
            
            break
        case .login:
            remove(asChildViewController: splashVC)
            remove(asChildViewController: registerVC)
            add(asChildViewController: loginVC)
            
            break
        case .register:
            remove(asChildViewController: splashVC)
            remove(asChildViewController: loginVC)
            add(asChildViewController: registerVC)
            
            break
        default: break
        }
    }
}
