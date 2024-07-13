//
//  CustomAnimationToPresentAndDismiss.swift
//  PresentationAnimation
//
//  Created by Keshari  on 13/07/24.
//

import Foundation
import UIKit

class CustomAnimationToPresentAndDismissDelegate: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    private let config: AnimationTransitionConfig
    private var isPresenting: Bool

    init(config: AnimationTransitionConfig, isPresenting: Bool = true) {
        self.config = config
        self.isPresenting = isPresenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return isPresenting ? config.presentationDuration : config.dismissalDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if isPresenting {
            guard let toViewController = transitionContext.viewController(forKey: .to) else {
                return
            }
            
            toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
            toViewController.view.transform = CGAffineTransform(translationX: 0, y: containerView.frame.height)
            containerView.addSubview(toViewController.view)
            
            UIView.animate(
                withDuration: transitionDuration(using: transitionContext),
                delay: 0,
                options: config.presentationOptions,
                animations: {
                    toViewController.view.transform = .identity
                },
                completion: { finished in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            )
        } else {
            guard let fromViewController = transitionContext.viewController(forKey: .from) else {
                return
            }
            
            UIView.animate(
                withDuration: transitionDuration(using: transitionContext),
                delay: 0,
                options: config.dismissalOptions,
                animations: {
                    fromViewController.view.transform = CGAffineTransform(translationX: 0, y: containerView.frame.height)
                },
                completion: { finished in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            )
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}
extension CustomAnimationToPresentAndDismissDelegate: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return self
    }
}
