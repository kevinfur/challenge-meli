//
//  QuestionsTableViewController.swift
//  challenge-meli
//
//  Created by Kevin Furman on 13/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation
import UIKit

class QuestionsTableViewController: UITableViewController {
    
    var id: String?
    
    var items: [Question] = [] {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        tableView.backgroundView = spinner        
        
        registerCell(QuestionCell.self)
        
        fetchQuestions()
    }
    
    private func fetchQuestions() {
        guard let id = id else { return }
        
        MeLiService.fetchQuestions(id: id, completion: { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            
            switch (response, error) {
            case (let .some(response), .none):
                strongSelf.items = response.questions
                strongSelf.tableView.backgroundView = UIView()
            case (.none, let .some(error)):
                print(error)
            default: break
            }
        })
    }
    
    private func registerCell<T>(_ cellType: T.Type) {
        let nibCell = UINib(nibName: "\(cellType.self)", bundle: Bundle(for: type(of: self)))
        tableView.register(nibCell, forCellReuseIdentifier: "\(cellType.self)")
    }
    
    public static func make(id: String) -> QuestionsTableViewController? {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle(for: self))
        guard let questionsTVC = storyboard.instantiateViewController(withIdentifier: "QuestionsTableViewController") as? QuestionsTableViewController else { return nil }
        questionsTVC.id = id
        return questionsTVC
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

}

extension QuestionsTableViewController {
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(QuestionCell.self)", for: indexPath) as? QuestionCell else { return UITableViewCell()}

        cell.configure(with: item)
        
        return cell
    }
    
}
