//
//  SearchItem.swift
//  challenge-meli
//
//  Created by Kevin Furman on 05/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation

struct SearchItem: Decodable {
    
    public let id: String
    public let title: String
    public let price: Double
    public let thumbnail: URL
    
}
