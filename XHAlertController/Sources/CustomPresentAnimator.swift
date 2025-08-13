//
//  CustomPresentAnimator.swift
//  XHAlertController
//
//  Created by 梁先华 on 2025/8/12.
//

import UIKit

public class CustomPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    public var duration: TimeInterval = 0.3
    public var maskColor: UIColor = .black
    public var maskAlpha: CGFloat = 0.6
    public var present = true
    public convenience init(_ present: Bool = true,
                            maskColor: UIColor? = nil,
                            maskAlpha: CGFloat? = nil,
                            duration: TimeInterval? = nil)
    {
        self.init()
        if let maskColor = maskColor {
            self.maskColor = maskColor
        }
        if let maskAlpha = maskAlpha {
            self.maskAlpha = maskAlpha
        }
        if let duration = duration {
            self.duration = duration
        }
        self.present = present
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        let containerView = transitionContext.containerView
        if present {
            containerView.addSubview(toVC.view)
            toVC.view.alpha = 0.0
            toVC.view.backgroundColor = .clear
            UIView.animate(withDuration: duration, animations: { [weak self] in
                guard let wself = self else { return }
                toVC.view.alpha = 1.0
                toVC.view.backgroundColor = wself.maskColor.withAlphaComponent(wself.maskAlpha)
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
        } else {
            UIView.animate(withDuration: duration, animations: {
                fromVC.view.alpha = 0.0
                fromVC.view.backgroundColor = .clear
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            })
        }
    }
}
