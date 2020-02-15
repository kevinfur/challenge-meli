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
    @IBOutlet weak var questionDateLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerDateLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        questionView.backgroundColor = UIColor.white
        answerView.backgroundColor = Colors.blackTone4
        
        questionDateLabel.textColor = Colors.blackTone3
        answerDateLabel.textColor = Colors.blackTone3
        
        questionLabel.textColor = Colors.blackTone2
        answerLabel.textColor = Colors.blackTone2
    }
    
    public func configure(with question: Question) {
        answerView.isHidden = question.answer == nil
        questionDateLabel.text = question.date.asString()
        questionLabel.text = question.text
        answerDateLabel.text = question.answer?.date.asString()
        answerLabel.text = question.answer?.text
    }
    
}
