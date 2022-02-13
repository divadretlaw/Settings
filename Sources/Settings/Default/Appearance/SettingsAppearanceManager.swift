//
//  SettingsApperanceManager.swift
//  Settings
//
//  Created by David Walter on 06.02.21.
//

import Foundation
#if os(iOS)
import UIKit
import SwiftUI
#elseif os(macOS)
import AppKit
#endif

extension Settings.Appearance {
    enum Mode: Int, Identifiable {
        case manual
        case scheduled
        case automatically
        
        var id: Int { self.rawValue }
    }
    
    class Manager {
        static var shared = Manager()
        
        init() {
            _ = NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: self, queue: nil) { _ in
                self.apply()
            }
            
            #if os(iOS)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(brightnessDidChange),
                                                   name: UIScreen.brightnessDidChangeNotification,
                                                   object: nil)
            #endif
        }
        
        @objc func brightnessDidChange() {
            guard self.mode == .automatically else { return }
            self.apply()
        }
        
        var mode: Mode {
            Mode(rawValue: Settings.Appearance.mode) ?? .manual
        }
        
        var useDarkMode: Bool {
            switch mode {
            case .manual:
                return Settings.Appearance.useDarkMode
            case .scheduled:
                return Settings.Appearance.useDarkMode
            case .automatically:
                #if os(iOS)
                return UIScreen.main.brightness <= Settings.Appearance.threshold
                #else
                return Settings.Appearance.useDarkMode
                #endif
            }
        }
        
        #if os(iOS)
        var userInterfaceStyle: UIUserInterfaceStyle {
            guard !Settings.Appearance.matchSystemTheme else {
                return .unspecified
            }
            return useDarkMode ? .dark : .light
        }
        
        var colorScheme: ColorScheme? {
            guard !Settings.Appearance.matchSystemTheme else {
                return nil
            }
            return useDarkMode ? .dark : .light
        }
        
        func apply(on viewController: UIViewController?) {
            viewController?.overrideUserInterfaceStyle = userInterfaceStyle
        }
        
        func apply(on window: UIWindow?) {
            window?.overrideUserInterfaceStyle = userInterfaceStyle
        }
        
        func apply() {
            UIApplication.shared.windows.forEach { apply(on: $0) }
            NotificationCenter.default.post(name: Settings.schemeDidChange, object: self)
        }
        #elseif os(macOS)
        var appearance: NSAppearance? {
            guard !Settings.Appearance.matchSystemTheme else {
                return nil
            }
            return NSAppearance(named: useDarkMode ? .darkAqua : .aqua)
        }
        
        func apply(on viewController: NSViewController?) {
            viewController?.view.appearance = appearance
        }
        
        func apply(on window: NSWindow?) {
            window?.appearance = appearance
        }
        
        func apply() {
            NSApplication.shared.windows.forEach { apply(on: $0) }
            NotificationCenter.default.post(name: Settings.schemeDidChange, object: self)
        }
        #endif
    }
}
