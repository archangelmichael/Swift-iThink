//
//  Date+String.swift
//  iThink
//
//  Created by Radi Shikerov on 12.04.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

extension Date {
    func toDateTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self)
    }
    
    func toDateTimeEscapedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        return formatter.string(from: self)
    }
}
