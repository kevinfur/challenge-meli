//
//  ItemCell.swift
//  challenge-meli
//
//  Created by Kevin Furman on 05/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import UIKit
import Kingfisher

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = Colors.blackTone2
        priceLabel.textColor = Colors.blackTone1
    }
    
    public func configure(with item: SearchItem) {
        picture.kf.setImage(with: item.thumbnail)
        titleLabel.text = item.title
        priceLabel.text = item.price.toPriceString()
    }
    
}
