//
//  ItemsTableViewController.swift
//  challenge-meli
//
//  Created by Kevin Furman on 31/01/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    var items: [SearchItem] = [] {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell(ItemCell.self)
    }
    
    private func registerCell<T>(_ cellType: T.Type) {
        let nibCell = UINib(nibName: "\(cellType.self)", bundle: Bundle(for: type(of: self)))
        tableView.register(nibCell, forCellReuseIdentifier: "\(cellType.self)")
    }

}

extension ItemsTableViewController {
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ItemCell.self)", for: indexPath) as? ItemCell else { return UITableViewCell()}

        cell.configure(with: item)
        
        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        print(item)
    }
    
}
