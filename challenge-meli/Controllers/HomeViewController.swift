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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var stackTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.yellow
        titleLabel.textColor = Colors.blackTone2
        
        searchBar.barTintColor = Colors.yellow
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let searchBarText = searchBar.text, let searchVC = SearchViewController.make(query: searchBarText) else { return }
        
        let navController = UINavigationController(rootViewController: searchVC)
        navController.transitioningDelegate = self
        navController.modalPresentationCapturesStatusBarAppearance = true
        self.present(navController, animated: true, completion: nil)
    }
    
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SearchPresentAnimationController()
    }
    
}

