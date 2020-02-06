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
        priceFormatter.numberStyle = .currency
        priceFormatter.maximumFractionDigits = 0
        priceFormatter.locale = Locale(identifier: "es_AR")
        let priceString = priceFormatter.string(from: self as NSNumber)?.replacingOccurrences(of: " ", with: "")
        return priceString ?? ""
    }
    
}
