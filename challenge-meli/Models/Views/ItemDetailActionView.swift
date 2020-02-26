//
//  ItemDetailActionView.swift
//  challenge-meli
//
//  Created by Kevin Furman on 25/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation
import UIKit

class ItemDetailActionView: UIView, NibInstantiable {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    public var viewData: ViewData? {
        didSet {
            guard let viewData = viewData else { return }
            titleLabel.text = viewData.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = Colors.blackTone2
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didTapView)))
        self.isUserInteractionEnabled = true
    }
    
    @objc func didTapView() {
        guard let viewData = viewData else { return }
        viewData.action()
    }
    
    public struct ViewData {
        public let title: String
        public let action: (() -> Void)
    }
    
}
