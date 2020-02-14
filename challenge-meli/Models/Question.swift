//
//  Question.swift
//  challenge-meli
//
//  Created by Kevin Furman on 13/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation

struct Question: Decodable {
    
    public let date: Date
    public let text: String
    public let answer: Answer?
    
    enum CodingKeys: String, CodingKey {
        case date = "date_created"
        case text
        case answer
    }
    
}
