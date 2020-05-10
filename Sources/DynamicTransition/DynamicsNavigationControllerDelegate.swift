//  Created by dasdom on 09.05.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import UIKit

public enum DynamicTransitionType {
  case snap
  case gravity
}

public class DynamicsNavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
  
  public var type = DynamicTransitionType.snap
  
  public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    switch type {
    case .snap:
      return SnapTransition(operation: operation)
    case .gravity:
      return GravityTransition(operation: operation)
    }
  }
}
