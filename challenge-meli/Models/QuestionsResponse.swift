//
//  QuestionsResponse.swift
//  challenge-meli
//
//  Created by Kevin Furman on 13/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation

struct QuestionsResponse: Decodable {
    
    public let questions: [Question]
    
}
