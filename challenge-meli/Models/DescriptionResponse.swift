//
//  DescriptionResponse.swift
//  challenge-meli
//
//  Created by Kevin Furman on 11/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation

struct DescriptionResponse: Decodable {
    
    public let plainText: String
    
    enum CodingKeys: String, CodingKey {
        case plainText = "plain_text"
    }
    
}
