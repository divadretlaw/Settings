//
//  UIViewControllerExtensions.swift
//  Settings
//
//  Created by David Walter on 19.09.20.
//

#if canImport(UIKit)
import UIKit

extension UIViewController {
    func topViewController() -> UIViewController? {
        if let nvc = self as? UINavigationController {
            return nvc.visibleViewController?.topViewController()
        } else if let tbc = self as? UITabBarController, let selected = tbc.selectedViewController {
            return selected.topViewController()
        } else if let presented = presentedViewController {
            return presented.topViewController()
        }
        return self
    }
}
#endif
