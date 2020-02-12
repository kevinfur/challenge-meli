//
//  UIStackView+RemoveAllSubviews.swift
//  challenge-meli
//
//  Created by Kevin Furman on 11/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation
import UIKit

internal extension UIStackView {

    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
}
