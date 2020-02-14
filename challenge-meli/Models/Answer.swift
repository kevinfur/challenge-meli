//
//  Answer.swift
//  challenge-meli
//
//  Created by Kevin Furman on 14/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation

struct Answer: Decodable {
    
    public let date: Date
    public let text: String
    
    enum CodingKeys: String, CodingKey {
        case date = "date_created"
        case text
    }
    
}
