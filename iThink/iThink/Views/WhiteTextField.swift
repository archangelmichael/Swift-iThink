//
//  WhiteTextField.swift
//  iThink
//
//  Created by Radi Shikerov on 23.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

//@IBDesignable
class WhiteTextField: UITextField {

    @IBInspectable
    var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = borderRadius
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 1.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var placeholderTextColor : UIColor = UIColor.lightGray {
        didSet {
            self.updatePlaceholder()
        }
    }
    
    override var placeholder: String? {
        didSet {
            self.updatePlaceholder()
        }
    }
    
    func updatePlaceholder() {
        if let placeholderText = self.placeholder {
            let placeholderTextAttributes: [NSAttributedStringKey: Any] = [
                .foregroundColor : placeholderTextColor
            ];
            
            self.attributedPlaceholder = NSAttributedString.init(string: placeholderText,
                                                                 attributes: placeholderTextAttributes)
        }
    }
    
    func invalidate() {
        self.text = nil
        self.invalidatePlaceholder()
        self.becomeFirstResponder()
    }
    
    func invalidatePlaceholder() {
        if let placeholderText = self.placeholder {
            let placeholderTextAttributes: [NSAttributedStringKey: Any] = [
                .foregroundColor : AppConstants.Colors.InvalidInput
            ];
            
            self.attributedPlaceholder = NSAttributedString.init(string: placeholderText,
                                                                 attributes: placeholderTextAttributes)
        }
    }
}
