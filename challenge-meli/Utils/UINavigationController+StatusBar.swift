//
//  UINavigationController+StatusBar.swift
//  challenge-meli
//
//  Created by Kevin Furman on 02/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    override open var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
         return visibleViewController?.preferredStatusBarStyle ?? .darkContent
    }
    
}
