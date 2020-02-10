//
//  ItemDetailViewController.swift
//  challenge-meli
//
//  Created by Kevin Furman on 09/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation
import UIKit

class ItemDetailViewController: UIViewController {

    var id: String?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let id = id else { return }
        MeLiService.fetchItem(id: id, completion: { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            
            switch (response, error) {
            case (let .some(response), .none):
                print(response)
            case (.none, let .some(error)):
                print(error)
            default: break
            }
        })
    }
    
    public static func make(id: String) -> ItemDetailViewController? {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle(for: self))
        guard let itemDetailVC = storyboard.instantiateViewController(withIdentifier: "ItemDetailViewController") as? ItemDetailViewController else { return nil }
        itemDetailVC.id = id
        return itemDetailVC
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
}
