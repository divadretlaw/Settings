//
//  Settings.swift
//  Settings
//
//  Created by David Walter on 27.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public struct Settings {
   @propertyWrapper public struct Entry<Value> {
        let key: String
        let `default`: Value
        
        public init(_ key: String, default: Value) {
            self.key = key
            self.default = `default`
        }
        
        public var wrappedValue: Value {
            get {
                UserDefaults.standard.object(forKey: key) as? Value ?? self.default
            }
            set {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
    
    public struct Configuration {
        #if os(iOS)
        public static var shared = Configuration(mailOptions: MFMailView.Options(toRecipients: nil,
                                                                                 ccRecipients: nil,
                                                                                 bccRecipients: nil,
                                                                                 subject: nil,
                                                                                 messageBody: nil))
        
        public var mailOptions: MFMailView.Options
        
        public init(mailOptions: MFMailView.Options) {
            self.mailOptions = mailOptions
        }
        #endif
    }
    
    #if os(iOS)
    public static func apply(on window: UIWindow?) {
        Settings.Appearance.apply(on: window)
        Passcode.shared.authenticate(animated: false)
    }
    #elseif os(macOS)
    public static func apply(on window: NSWindow?) {
        Settings.Appearance.apply(on: window)
        Passcode.shared.authenticate(animated: false)
    }
    #endif
    
    public static func apply() {
        Application.shared.windows.forEach { apply(on: $0) }
        Passcode.shared.authenticate(animated: false)
    }
}

public extension Settings {
    struct Appearance {
        @Entry("Settings:Appearance-matchSystemTheme", default: true)
        public static var matchSystemTheme: Bool
        
        @Entry("Settings:Appearance-useDarkMode", default: false)
        public static var useDarkMode: Bool
        
        #if os(iOS)
        public static func apply(on viewController: UIViewController?) {
            guard Settings.Appearance.matchSystemTheme else { return }
            viewController?.overrideUserInterfaceStyle = Settings.Appearance.useDarkMode ? .dark : .light
        }
        
        public static func apply(on window: UIWindow?) {
            guard Settings.Appearance.matchSystemTheme else { return }
            window?.overrideUserInterfaceStyle = Settings.Appearance.useDarkMode ? .dark : .light
        }
        
        public static func apply() {
            UIApplication.shared.windows.forEach { apply(on: $0) }
        }
        #elseif os(macOS)
        public static func apply(on viewController: NSViewController?) {
            guard Settings.Appearance.matchSystemTheme else { return }
            viewController?.view.appearance = NSAppearance(named: Settings.Appearance.useDarkMode ? .darkAqua : .aqua)
        }
        
        public static func apply(on window: NSWindow?) {
            guard Settings.Appearance.matchSystemTheme else { return }
            window?.appearance = NSAppearance(named: Settings.Appearance.useDarkMode ? .darkAqua : .aqua)
        }
        
        public static func apply() {
            NSApplication.shared.windows.forEach { apply(on: $0) }
        }
        #endif
    }
}
