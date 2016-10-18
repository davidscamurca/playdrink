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
        case Present, Dismiss
    }
    
    var circle : UIView?
    var circleColor : UIColor?
    var origin = CGPointZero
    
    var transitionMode: PopTransitionMode = .Present
    
    let presentDuration = 0.3
    let dismissDuration = 0.1
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        if self.transitionMode == .Present {
            return self.presentDuration
        }else {
            return self.dismissDuration
        }
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
        let containerView = transitionContext.containerView()
        let presentView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let returnView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        if self.transitionMode == .Present {
            
            presentView.center = origin
            presentView.transform = CGAffineTransformMakeScale(0.8, 0.7)
            presentView.layer.cornerRadius = 20
            presentView.backgroundColor = circleColor
            containerView?.addSubview(presentView)
            
            UIView.animateWithDuration(presentDuration, animations: {
                
                presentView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }) { (_) in
                    presentView.layer.cornerRadius = 0
                    transitionContext.completeTransition(true)
            }
        }else {
            
            containerView?.addSubview(presentView)
            containerView?.addSubview(returnView)
            returnView.layer.cornerRadius = 20

            UIView.animateWithDuration(dismissDuration, animations: {
                
                returnView.transform = CGAffineTransformMakeScale(0.8, 0.7)
                returnView.center = self.origin

                }) { (_) in
                    returnView.removeFromSuperview()
                    transitionContext.completeTransition(true)
            }
        }
    }
}
