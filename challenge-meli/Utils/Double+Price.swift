//
//  Double+Price.swift
//  challenge-meli
//
//  Created by Kevin Furman on 05/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation

extension Double {
    
    func toPriceString() -> String {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .decimal
        priceFormatter.maximumFractionDigits = 0
        priceFormatter.groupingSeparator = "."
        if let priceString = priceFormatter.string(from: self as NSNumber)?.replacingOccurrences(of: " ", with: "") {
            return "$" + priceString
        }
        return ""
    }
    
}
