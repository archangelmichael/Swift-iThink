//
//  PickerItem.swift
//  iThink
//
//  Created by Radi Shikerov on 1.03.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class PickerItem: NSObject {

    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
