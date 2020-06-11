//
//  UIApplicationExtension.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UIApplication {
    var rootWindow: UIWindow? {
        windows.first(where: { $0.isKeyWindow }) ?? windows.last
    }
    
    func updateAppearance() {
        self.windows.forEach {
            if !Settings.Appearance.matchSystemTheme {
                Settings.Appearance.Manager.shared.apply()
            } else {
                $0.overrideUserInterfaceStyle = .unspecified
            }
        }
    }
}
#endif
