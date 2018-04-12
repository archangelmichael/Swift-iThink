//
//  String+Whitespace.swift
//  iThink
//
//  Created by Radi Shikerov on 12.04.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

extension String {
    var condensedWhitespace: String? {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
