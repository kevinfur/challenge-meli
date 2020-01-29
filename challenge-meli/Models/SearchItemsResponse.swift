//
//  SearchItemsResponse.swift
//  challenge-meli
//
//  Created by Kevin Furman on 29/01/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation

struct SearchItemsResponse: Decodable {
    
    public let query: String
    public let results: [Item]
    
}

struct Item: Decodable {
    
    public let id: String
    public let title: String
    public let price: Double
    public let thumbnail: String
    
}
