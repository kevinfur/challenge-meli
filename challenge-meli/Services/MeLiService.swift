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
        static let BaseURL = "https://api.mercadolibre.com"
    }
    
    enum Errors: Error {
        case invalidQuery
    }
    
    static func searchItems(query: String, completion: @escaping (SearchItemsResponse?, Error?) -> ()) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            completion(nil, Errors.invalidQuery)
            return
        }
        
        let url = Constants.BaseURL + "/sites/MLA/search"
        
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
    
    static func fetchItem(id: String, completion: @escaping (ItemDetailResponse?, Error?) -> ()) {
        let url = Constants.BaseURL + "/items"
        
        let parameters: Parameters = ["ids": id]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    if let data = response.data {
                        let response = try decoder.decode(ItemDetailResponse.self, from: data)
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
    
    static func fetchDescription(id: String, completion: @escaping (DescriptionResponse?, Error?) -> ()) {
        let url = Constants.BaseURL + "/items/" + id + "/description"
        
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                do {
                    if let data = response.data {
                        let response = try decoder.decode(DescriptionResponse.self, from: data)
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
