//
//  SearchViewController.swift
//  challenge-meli
//
//  Created by Kevin Furman on 31/01/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Buscar productos, marcas y más..."
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
//        self.definesPresentationContext = true
        
        navigationItem.titleView = searchController.searchBar
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = Colors.yellow
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
        
        //        MeLiService.searchItems(query: "iphone 11", completion: { (response, error) in
        //            print(response)
        //        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

}
