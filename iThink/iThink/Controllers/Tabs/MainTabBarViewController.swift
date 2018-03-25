//
//  MainTabBarViewController.swift
//  iThink
//
//  Created by Radi Shikerov on 2.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBarStyle()
        self.setupTabBarImages()
    }
    
    func setupTabBarStyle() {
        self.tabBar.barTintColor = UIColor.red
        self.tabBar.backgroundImage = UIImage()
    }
    
    func setupTabBarImages() {
        guard let tabBarItems = self.tabBar.items, tabBarItems.count > 1 else {
            print("Invalid tab bar configuration")
            return
        }
        
        let quotesTab = UIImage(named: "quotes_tab")?.resize(width: 30, height: 30)
        let profileTab = UIImage(named: "profile_tab")?.resize(width: 30, height: 30)
        
        tabBarItems[0].image = quotesTab
        tabBarItems[1].image = profileTab
    }
}
