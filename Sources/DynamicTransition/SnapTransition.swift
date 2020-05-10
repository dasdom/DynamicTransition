//  Created by dasdom on 09.05.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit

class SnapTransition: NSObject, UIViewControllerAnimatedTransitioning {
  
  let operation: UINavigationController.Operation
  
  internal init(operation: UINavigationController.Operation) {
    self.operation = operation
    
    super.init()
  }

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 1
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let fromVC = transitionContext.viewController(forKey: .from),
      let toVC = transitionContext.viewController(forKey: .to)
      else {
        return
    }
    
    let containerView = transitionContext.containerView
    var animator: UIDynamicAnimator? = UIDynamicAnimator(referenceView: containerView)

    if operation == .push {
      toVC.view.frame = fromVC.view.frame.offsetBy(dx: 0.6*fromVC.view.frame.size.width, dy: 0)
      
      containerView.addSubview(toVC.view)
      
      let snapBehavior = UISnapBehavior(item: toVC.view, snapTo: fromVC.view.center)
      snapBehavior.damping = 0.5
      
      animator?.addBehavior(snapBehavior)
    
    } else {
    
      toVC.view.frame = fromVC.view.frame

      containerView.insertSubview(toVC.view, at: 0)
      
      let snapBehavior = UISnapBehavior(item: fromVC.view, snapTo: CGPoint(x: 1.6*fromVC.view.frame.size.width, y: fromVC.view.center.y + 50))

      animator?.addBehavior(snapBehavior)

    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + transitionDuration(using: transitionContext)) {
      animator = nil
      transitionContext.completeTransition(true)
    }
  }
}
