//
//  LeftViewTextField.swift
//  fitgram
//
//  Created by boyuan lin on 11/11/19.
//  Copyright © 2019 boyuan lin. All rights reserved.
//

import UIKit

class LeftViewTextField:UITextField {
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        if (self.leftView != nil) {
            return CGRect(x: bounds.origin.x + self.leftView!.bounds.size.width + 5, y:  bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
        } else {
            return bounds
        }
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if (self.leftView != nil) {
            return CGRect(x: bounds.origin.x + self.leftView!.bounds.size.width + 5, y:  bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
        } else {
            return bounds
        }
    }
}

