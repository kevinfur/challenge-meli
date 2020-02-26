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
  
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var picturesStackView: UIStackView!
    @IBOutlet weak var picturesScrollView: UIScrollView!
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var questionsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picturesScrollView.alwaysBounceHorizontal = true
        picturesScrollView.showsHorizontalScrollIndicator = false
        picturesScrollView.isPagingEnabled = true
        picturesScrollView.backgroundColor = UIColor.white
        
        titleLabel.text = ""
        priceLabel.text = ""
        
        descriptionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didTapGoToDescription)))
        descriptionView.isUserInteractionEnabled = true
        
        questionsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didTapGoToQuestions)))
        questionsView.isUserInteractionEnabled = true
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = Colors.blackTone2
        
        fetchItem()
    }
    
    private func fetchItem() {
        guard let id = id else { return }
        
        MeLiService.fetchItem(id: id, completion: { [weak self] (response, error) in
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
    
    @objc func didTapGoToDescription() {
        guard let id = id, let descriptionVC = DescriptionViewController.make(id: id) else { return }        
        navigationController?.pushViewController(descriptionVC, animated: true)
    }
    
    @objc func didTapGoToQuestions() {
        guard let id = id, let questionsVC = QuestionsTableViewController.make(id: id) else { return }
        navigationController?.pushViewController(questionsVC, animated: true)
    }
    
    private func loadData(from item: ItemDetailResponse) {
        titleLabel.text = item.title
        priceLabel.text = item.price.toPriceString()
        
        picturesStackView.removeAllSubviews()
        item.pictures.forEach({ pictureURL in
            let imageView = UIImageView()
            
            imageView.contentMode = .scaleAspectFit
            imageView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: picturesScrollView.frame.size.height).isActive = true
            
            imageView.kf.setImage(with: pictureURL)
            
            picturesStackView.addArrangedSubview(imageView)
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
