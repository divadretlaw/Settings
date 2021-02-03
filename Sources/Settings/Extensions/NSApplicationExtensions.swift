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
                $0.appearance = NSAppearance(named: Settings.Appearance.useDarkMode ? .darkAqua : .aqua)
            } else {
                $0.appearance = nil
            }
        }
    }
}
#endif
