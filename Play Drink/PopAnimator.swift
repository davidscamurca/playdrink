//
//  PopAnimator.swift
//  kid
//
//  Created by Anderson Oliveira on 08/07/16.
//  Copyright © 2016 Thiago Vinhote. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    enum PopTransitionMode: Int {
        case present, dismiss
    }
    
    var circle : UIView?
    var circleColor : UIColor?
    var origin = CGPoint.zero
    
    var transitionMode: PopTransitionMode = .present
    
    let presentDuration = 0.3
    let dismissDuration = 0.1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        if self.transitionMode == .present {
            return self.presentDuration
        }else {
            return self.dismissDuration
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
        let containerView = transitionContext.containerView
        let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        let returnView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        if self.transitionMode == .present {
            
            presentView.center = origin
            presentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.7)
            presentView.layer.cornerRadius = 20
            presentView.backgroundColor = circleColor
            containerView.addSubview(presentView)
            
            UIView.animate(withDuration: presentDuration, animations: {
                
                presentView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: { (_) in
                    presentView.layer.cornerRadius = 0
                    transitionContext.completeTransition(true)
            }) 
        }else {
            
            containerView.addSubview(presentView)
            containerView.addSubview(returnView)
            returnView.layer.cornerRadius = 20

            UIView.animate(withDuration: dismissDuration, animations: {
                
                returnView.transform = CGAffineTransform(scaleX: 0.8, y: 0.7)
                returnView.center = self.origin

                }, completion: { (_) in
                    returnView.removeFromSuperview()
                    transitionContext.completeTransition(true)
            }) 
        }
    }
}
