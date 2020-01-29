//
//  ViewController.swift
//  challenge-meli
//
//  Created by Kevin Furman on 29/01/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = Colors.yellow
        titleLabel.textColor = Colors.blackTone2
        
//        MeLiService.searchItems(query: "iphone 11", completion: { (response, error) in
//            print(response)
//        })
    }


}

