//
//  UIView+NibInstantiable.swift
//  challenge-meli
//
//  Created by Kevin Furman on 31/01/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation
import UIKit

protocol NibInstantiable { }

extension NibInstantiable where Self: UIView {
    
    static func loadFromNib() -> Self {
        let className = String(describing: self)
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: className, bundle: bundle)
        
        return nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
    
}
