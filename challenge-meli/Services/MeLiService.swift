//
//  AppDelegate.swift
//  challenge-meli
//
//  Created by Kevin Furman on 29/01/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation
import Alamofire

struct MeLiService {
    
    private init() { }
    
    struct Constants {
        static let APIPath = "https://api.mercadolibre.com/sites/MLA"
    }
    
    enum Errors: Error {
        case invalidQuery
    }
    
    static func searchItems(query: String, completion: @escaping (SearchItemsResponse?, Error?) -> ()) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            completion(nil, Errors.invalidQuery)
            return
        }
        
        let url = Constants.APIPath + "/search"
        
        let parameters: Parameters = ["q": encodedQuery]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    if let data = response.data {
                        let response = try decoder.decode(SearchItemsResponse.self, from: data)
                        completion(response, nil)
                    }
                } catch let error {
                    print(error)
                    completion(nil, error)
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
            
        }
    }

}
