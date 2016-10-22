//
//  TransitioningDelegate.swift
//  Rappi
//
//  Created by lbriceno on 10/20/16.
//  Copyright © 2016 Lbriceno. All rights reserved.
//

import UIKit


class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var openingFrame: CGRect?
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let presentationAnimator = PresentationAnimator()
        presentationAnimator.openingFrame = openingFrame!
        return presentationAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let dismissAnimator = DismissalAnimator()
        dismissAnimator.openingFrame = openingFrame!
        return dismissAnimator
    }
    
   
}