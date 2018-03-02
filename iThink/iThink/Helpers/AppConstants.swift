//
//  AppConstants.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

struct AppConstants {
    struct Tags {
        static let LoadingView = 999
    }
    
    struct Strings {
        static let DefaultAuthor = "anonymous"
    }
    
    struct Segues {
        static let GoHome = "goToHome"
    }
    
    struct Colors {
        static let InputBackground = UIColor.white.withAlphaComponent(0.4)
        static let InvalidInput = UIColor(rgb: 0xDD001F)
    }
}
