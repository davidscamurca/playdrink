//
//  DetailTransitionDelegate.swift
//  Stephen Melinyshyn
//
//  Created by Stephen Melinyshyn on 2015-04-14.
//  Copyright (c) 2015 Stevo Productions. All rights reserved.
//

import UIKit

class DetailTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
	override init() {
		super.init()
	}
	
	//MARK: UIViewControllerTransitioningDelegate methods
	func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return self
	}
	
	func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return self
	}
	
	//MARK: UIViewControllerAnimatedTransitioning methods
	
	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return 0.5 // this isn't called on purpose
	}
	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		var isGoingToDetailView = true
		let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
		let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
		
		if toViewController is GameViewController {
			isGoingToDetailView = false
		}
		
		let containerView = transitionContext.containerView()
		containerView!.addSubview(toViewController.view!)
		containerView!.addSubview(fromViewController.view!)
		
		//		let animationDuration = self.transitionDuration(transitionContext)
		
		if isGoingToDetailView {
			let topCard = fromViewController.view.subviews.last as UIView!
			toViewController.view.backgroundColor = topCard.backgroundColor
		} else { //back to master
			(toViewController  as! GameViewController).didReturnFromTransition = true
		}
		
		
		
		//fromViewController?.view.alpha = 0.0
		fromViewController.view.removeFromSuperview()
		transitionContext.completeTransition(true)
		if !isGoingToDetailView {
			UIApplication.sharedApplication().keyWindow?.addSubview(toViewController.view)
		}
	}
}