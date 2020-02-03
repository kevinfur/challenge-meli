//
//  UIView+PinToSuperview.swift
//  challenge-meli
//
//  Created by Kevin Furman on 01/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import UIKit

internal extension UIView {
    
    func pinToSuperview() {
        if let superview = superview {
            translatesAutoresizingMaskIntoConstraints = false
            superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view": self]))
            superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": self]))
        }
    }
    
}
