//  Created by dasdom on 09.05.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit

class GravityTransition: NSObject, UIViewControllerAnimatedTransitioning {
  
  let operation: UINavigationController.Operation
  
  internal init(operation: UINavigationController.Operation) {
    self.operation = operation
    
    super.init()
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 1.5
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
      let fromFrame = fromVC.view.frame
      toVC.view.frame = fromFrame.offsetBy(dx: 0, dy: -1*fromFrame.size.height)
      
      containerView.addSubview(toVC.view)
      
      let gravityBehavior = UIGravityBehavior(items: [toVC.view])
      
      let collisionBehavior = UICollisionBehavior(items: [toVC.view])
      collisionBehavior.addBoundary(withIdentifier: "BottomBoundary" as NSCopying, from: CGPoint(x: 0, y: fromFrame.size.height+1), to: CGPoint(x: fromFrame.size.width, y: fromFrame.size.height+1))
      
      let dynamicBehavior = UIDynamicItemBehavior(items: [toVC.view])
      dynamicBehavior.elasticity = 0.2
      
      let pushBehavior = UIPushBehavior(items: [toVC.view], mode: .instantaneous)
      pushBehavior.angle = CGFloat(Double.pi/2)
      pushBehavior.magnitude = 100
      
      animator?.addBehavior(pushBehavior)
      animator?.addBehavior(dynamicBehavior)
      animator?.addBehavior(collisionBehavior)
      animator?.addBehavior(gravityBehavior)
    
    } else {
    
      containerView.insertSubview(toVC.view, at: 0)
      
      let gravityBehavior = UIGravityBehavior(items: [fromVC.view])

      let pushBehavior = UIPushBehavior(items: [fromVC.view], mode: .instantaneous)
      pushBehavior.angle = CGFloat(Double.pi/2)
      pushBehavior.magnitude = 100
      pushBehavior.setTargetOffsetFromCenter(UIOffset(horizontal: 30, vertical: 0), for: fromVC.view)
      
      animator?.addBehavior(pushBehavior)
      animator?.addBehavior(gravityBehavior)
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + transitionDuration(using: transitionContext)) {
      animator = nil
      transitionContext.completeTransition(true)
    }
  }
}
