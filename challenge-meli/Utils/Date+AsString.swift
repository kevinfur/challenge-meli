//
//  Date+AsString.swift
//  challenge-meli
//
//  Created by Kevin Furman on 15/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation

extension Date {
    
    func asString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
    
}
