//
//  SearchViewController.swift
//  challenge-meli
//
//  Created by Kevin Furman on 31/01/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var query: String? {
        didSet {
            pageNumber = 0
            searchItems()
        }
    }
    
    private var pageNumber: Int = 0
    private var maxPageToShow: Int = 5
    
    private weak var itemsTableViewController: ItemsTableViewController?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = Colors.blackTone2
    }
    
    func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Buscar productos, marcas y más..."
        searchController.searchBar.searchTextField.backgroundColor = UIColor.white
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.showsCancelButton = false
        
        navigationItem.titleView = searchController.searchBar
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = Colors.yellow
        
        self.definesPresentationContext = true
    }
    
    private func searchItems() {
        guard let query = query else { return }
        
        if pageNumber == 0 {
            itemsTableViewController?.items = []
        }
        
        searchController.searchBar.text = query
        MeLiService.searchItems(query: query, page: pageNumber, completion: { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            
            switch (response, error) {
            case (let .some(response), .none):
                if let currentItems = strongSelf.itemsTableViewController?.items {
                    strongSelf.itemsTableViewController?.items = currentItems + response.results
                }
            case (.none, let .some(error)):
                print(error)
            default: break
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedItemsTableSegue", let itemsTVC = segue.destination as? ItemsTableViewController {
            itemsTableViewController = itemsTVC
            itemsTableViewController?.delegate = self
        }
    }
    
    public static func make(query: String) -> SearchViewController? {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle(for: self))
        guard let searchVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return nil }
        searchVC.query = query
        return searchVC
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

}

extension SearchViewController: ItemsTableViewControllerDelegate {
    
    func itemHasBeenSelected(_ item: SearchItem) {
        if let itemDetailVC = ItemDetailViewController.make(id: item.id) {
            navigationController?.pushViewController(itemDetailVC, animated: true)
        }
    }
    
    func fetchNextPage() {
        pageNumber = pageNumber + 1
        if pageNumber < maxPageToShow {
            searchItems()
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        searchBar.resignFirstResponder()
        searchController.isActive = false
        query = searchBarText
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = query
    }
    
}
