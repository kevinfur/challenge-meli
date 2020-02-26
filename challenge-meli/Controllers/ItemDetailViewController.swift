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
    
    @IBOutlet weak var actionsStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picturesScrollView.alwaysBounceHorizontal = true
        picturesScrollView.showsHorizontalScrollIndicator = false
        picturesScrollView.isPagingEnabled = true
        picturesScrollView.backgroundColor = UIColor.white
        
        titleLabel.text = ""
        priceLabel.text = ""
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = Colors.blackTone2
        
        addActions()
        
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
    
    private func addActions() {
        let descriptionActionView = ItemDetailActionView.loadFromNib()
        descriptionActionView.viewData = ItemDetailActionView.ViewData(title: "Descripción", action: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.performSegue(withIdentifier: "fromDetailToDescriptionSegue", sender: nil)
        })
        actionsStack.addArrangedSubview(descriptionActionView)
        
        let questionsActionView = ItemDetailActionView.loadFromNib()
        questionsActionView.viewData = ItemDetailActionView.ViewData(title: "Preguntas", action: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.performSegue(withIdentifier: "fromDetailToQuestionsSegue", sender: nil)
        })
        actionsStack.addArrangedSubview(questionsActionView)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = self.id else { return }
        
        if segue.identifier == "fromDetailToDescriptionSegue", let descriptionVC = segue.destination as? DescriptionViewController {
            descriptionVC.id = id
        }
        
        if segue.identifier == "fromDetailToQuestionsSegue", let questionsVC = segue.destination as? QuestionsTableViewController {
            questionsVC.id = id
        }
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
