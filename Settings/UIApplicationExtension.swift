//
//  UIApplicationExtension.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    func updateAppearance() {
        self.windows.forEach {
            if !Settings.Appearance.matchSystemTheme {
                $0.overrideUserInterfaceStyle = Settings.Appearance.useDarkMode ? .dark : .light
            } else {
                $0.overrideUserInterfaceStyle = .unspecified
            }
        }
    }
}
