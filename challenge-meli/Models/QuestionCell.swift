//
//  QuestionCell.swift
//  challenge-meli
//
//  Created by Kevin Furman on 13/02/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation

import UIKit

class QuestionCell: UITableViewCell {
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        titleLabel.textColor = Colors.blackTone2
//        priceLabel.textColor = Colors.blackTone1
    }
    
    public func configure(with question: Question) {
        answerView.isHidden = question.answer == nil
        dateLabel.text = question.date.description
        questionLabel.text = question.text
        answerLabel.text = question.answer?.text
    }
    
}
