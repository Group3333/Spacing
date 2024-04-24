//
//  HalfModalPresentationController.swift
//  Spacing
//
//  Created by 서혜림 on 4/23/24.
//

import UIKit

class HalfModalPresentationController: UIPresentationController {
    
    private var dimmingView: UIView!
    private var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return CGRect.zero }
        let height: CGFloat = 300
        return CGRect(x: 0, y: containerView.bounds.height - height, width: containerView.bounds.width, height: height)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0
        containerView.insertSubview(dimmingView, at: 0)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        }, completion: nil)
        
        // 드래그 제스처 추가
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        presentedViewController.view.addGestureRecognizer(panGestureRecognizer)
        
        presentedViewController.view.layer.cornerRadius = 12
        presentedViewController.view.clipsToBounds = true
    }
    
    @objc private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let presentedView = presentedView else { return }
        
        let translation = gestureRecognizer.translation(in: presentedView)
        
        switch gestureRecognizer.state {
        case .began:
            initialTouchPoint = presentedView.frame.origin
        case .changed:
            presentedView.frame.origin = CGPoint(
                x: initialTouchPoint.x,
                y: initialTouchPoint.y + translation.y
            )
        case .ended, .cancelled:
            let velocity = gestureRecognizer.velocity(in: presentedView)
            if velocity.y > 0 {
                // 아래로 드래그: 모달 닫기
                presentingViewController.dismiss(animated: true, completion: nil)
            } else {
                // 위로 드래그: 모달 유지
                presentedView.frame.origin = initialTouchPoint
            }
        default:
            break
        }
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        }, completion: { _ in
            self.dimmingView.removeFromSuperview()
        })
    }
}
