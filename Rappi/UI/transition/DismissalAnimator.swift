//
//  DismissalAnimator.swift
//  Rappi
//
//  Created by lbriceno on 10/20/16.
//  Copyright © 2016 Lbriceno. All rights reserved.
//

import UIKit

class DismissalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
//    var openingFrame: CGRect?
//    
//    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
//        return 0.5
//    }
//    
//    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
//        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
//        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
//        let containerView = transitionContext.containerView()
//        
//        let animationDuration = self .transitionDuration(transitionContext)
//        
//        let snapshotView = fromViewController.view.resizableSnapshotViewFromRect(fromViewController.view.bounds, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
//        containerView!.addSubview(snapshotView)
//        
//        fromViewController.view.alpha = 0.0
//        
//        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
//            snapshotView.frame = self.openingFrame!
//            snapshotView.alpha = 0.0
//        }) { (finished) -> Void in
//            snapshotView.removeFromSuperview()
//            fromViewController.view.removeFromSuperview()
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
//        }
//    }
    
    var openingFrame: CGRect?
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView()
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as!EntryDetailViewController
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ViewController
        let button = fromViewController.cancelButton!
        
        containerView!.addSubview(toViewController.view)
        
        let circleMaskPathInitial = UIBezierPath(ovalInRect: button.frame)
        let extremePoint = CGPoint(x: button.center.x - 0, y: button.center.y - CGRectGetHeight(toViewController.view.bounds))
        let radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(button.frame, -radius, -radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        toViewController.view.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
        maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
        maskLayerAnimation.duration = self.transitionDuration(transitionContext)
        maskLayerAnimation.delegate = self
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.transitionContext?.completeTransition(true)
        self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
    }

}