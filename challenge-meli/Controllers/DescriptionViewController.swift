//
//  DescriptionViewController.swift
//  challenge-meli
//
//  Created by Kevin Furman on 11/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation
import UIKit

class DescriptionViewController: UIViewController {
    
    var id: String?
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDescription()
    }
    
    private func fetchDescription() {
        guard let id = id else { return }
        
        MeLiService.fetchDescription(id: id, completion: { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            
            switch (response, error) {
            case (let .some(response), .none):
                strongSelf.loadData(from: response)
            case (.none, let .some(error)):
                print(error)
            default: break
            }
        })
    }
    
    private func loadData(from response: DescriptionResponse) {
        descriptionLabel.text = response.plainText
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
}
