//
//  File.swift
//  
//
//  Created by David Walter on 06.02.21.
//

import Foundation
#if os(iOS)
import UIKit
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
        public func apply(on viewController: UIViewController?) {
            guard !Settings.Appearance.matchSystemTheme else { return }
            viewController?.overrideUserInterfaceStyle = useDarkMode ? .dark : .light
        }
        
        public func apply(on window: UIWindow?) {
            guard !Settings.Appearance.matchSystemTheme else { return }
            window?.overrideUserInterfaceStyle = useDarkMode ? .dark : .light
            
        }
        
        public func apply() {
            UIApplication.shared.windows.forEach { apply(on: $0) }
        }
        #elseif os(macOS)
        public func apply(on viewController: NSViewController?) {
            guard !Settings.Appearance.matchSystemTheme else { return }
            viewController?.view.appearance = NSAppearance(named: useDarkMode ? .darkAqua : .aqua)
        }
        
        public func apply(on window: NSWindow?) {
            guard !Settings.Appearance.matchSystemTheme else { return }
            window?.appearance = NSAppearance(named: useDarkMode ? .darkAqua : .aqua)
        }
        
        public func apply() {
            NSApplication.shared.windows.forEach { apply(on: $0) }
        }
        #endif
    }
}
