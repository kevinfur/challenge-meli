//
//  SearchPresentAnimationController.swift
//  challenge-meli
//
//  Created by Kevin Furman on 31/01/2020.
//  Copyright © 2020 Kevin Furman. All rights reserved.
//

import Foundation
import UIKit

class SearchPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.3
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let fromVC = transitionContext.viewController(forKey: .from) as? HomeViewController,
      let toVC = transitionContext.viewController(forKey: .to),
      let fromView = fromVC.view
      else {
        return
    }
    
    let containerView = transitionContext.containerView
    
    containerView.addSubview(toVC.view)
    toVC.view.pinToSuperview()
    
        containerView.addSubview(fromVC.view)
    
        fromVC.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view": fromView]))
        let fromViewBottomConstraint = NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: fromView, attribute: .bottom, multiplier: 1, constant: 0)
        containerView.addConstraint(fromViewBottomConstraint)
    let fromViewTopConstraint = NSLayoutConstraint(item: fromView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0)
        containerView.addConstraint(fromViewTopConstraint)
    
    let duration = transitionDuration(using: transitionContext)
    
    containerView.layoutIfNeeded()
    
    UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
        fromVC.titleLabel.alpha = 0
        fromVC.titleLabel.isHidden = true
        containerView.layoutIfNeeded()
    }, completion: { _ in
        fromVC.titleLabel.removeFromSuperview()
    })
    
    UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
        fromViewBottomConstraint.constant = UIApplication.shared.windows[0].frame.height - toVC.view.safeAreaInsets.top - (toVC.children.first?.navigationController?.navigationBar.frame.height ?? 0)
        fromVC.stackTopConstraint?.constant = -45
        fromViewTopConstraint.constant = toVC.view.safeAreaInsets.top
        containerView.layoutIfNeeded()
    }, completion: { _ in
        fromView.removeFromSuperview()
        transitionContext.completeTransition(true)
    })
    
  }
    
}

