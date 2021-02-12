//
//  NSApplicationExtensions.swift
//  
//
//  Created by David Walter on 28.12.20.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import Foundation
import AppKit

extension NSApplication {
    var rootWindow: NSWindow? {
        windows.first(where: { $0.isKeyWindow }) ?? windows.last
    }
    
    func updateAppearance() {
        self.windows.forEach {
            if !Settings.Appearance.matchSystemTheme {
                Settings.Appearance.Manager.shared.apply()
            } else {
                $0.appearance = nil
            }
        }
    }
}
#endif
