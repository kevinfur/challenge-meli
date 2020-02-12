//
//  ItemDetailResponse.swift
//  challenge-meli
//
//  Created by Kevin Furman on 09/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation

struct ItemDetailResponse: Decodable {
    
    let id: String
    let title: String
    let description: String?
    let pictures: [URL]
    let price: Double
    
    enum RootKeys: String, CodingKey {
        case body
    }

    enum ItemKeys: String, CodingKey {
        case id
        case title
        case descriptions
        case pictures
        case price
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        let rootContainer = try container.nestedContainer(keyedBy: RootKeys.self)
        let bodyContainer = try rootContainer.nestedContainer(keyedBy: ItemKeys.self, forKey: .body)

        id = try bodyContainer.decode(String.self, forKey: .id)
        title = try bodyContainer.decode(String.self, forKey: .title)
        
        let descriptions = try bodyContainer.decode([Description].self, forKey: .descriptions)
        description = descriptions.first?.id
        
        let pics = try bodyContainer.decode([Picture].self, forKey: .pictures)
        pictures = pics.compactMap({ $0.url })
        
        price = try bodyContainer.decode(Double.self, forKey: .price)
    }
    
    private struct Description: Decodable {
        public let id: String
    }
    
    private struct Picture: Decodable {
        public let url: URL
    }
    
}
