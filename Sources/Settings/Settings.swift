//
//  Settings.swift
//  Settings
//
//  Created by David Walter on 27.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

#if os(iOS)
import SwiftUI
import UIKit
#elseif os(macOS)
import AppKit
#endif

public enum Settings {
    public static let schemeDidChange = NSNotification.Name("Settings.schemeDidChange")
    
    static var userDefaults: UserDefaults = .standard
    
    @propertyWrapper public struct Entry<Value> {
        let key: String
        let `default`: Value
        
        public init(_ key: String, default: Value) {
            self.key = key
            self.default = `default`
        }
        
        public var wrappedValue: Value {
            get {
                Settings.userDefaults.object(forKey: key) as? Value ?? self.default
            }
            set {
                Settings.userDefaults.set(newValue, forKey: key)
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
        #else
        public static var shared = Configuration()
        
        public init() {
        }
        #endif
    }
    
    public static func set(userDefaults: UserDefaults = .standard) {
        Self.userDefaults = userDefaults
    }
    
    public static func set(configuration: Configuration) {
        Settings.Configuration.shared = configuration
    }
    
    #if os(iOS)
    public static var userInterfaceStyle: UIUserInterfaceStyle {
        Settings.Appearance.Manager.shared.userInterfaceStyle
    }
    
    public static var colorScheme: ColorScheme? {
        Settings.Appearance.Manager.shared.colorScheme
    }
    
    public static func apply(on window: UIWindow?) {
        Settings.Appearance.Manager.shared.apply(on: window)
        Passcode.shared.authenticate(animated: false)
    }

    #elseif os(macOS)
    public static var appearance: NSAppearance? {
        Settings.Appearance.Manager.shared.appearance
    }
    
    public static func apply(on window: NSWindow?) {
        Settings.Appearance.Manager.shared.apply(on: window)
        Passcode.shared.authenticate(animated: false)
    }
    #endif
    
    public static func apply() {
        Application.shared.windows.forEach { apply(on: $0) }
        Passcode.shared.authenticate(animated: false)
    }
}

extension Settings {
    public enum Appearance {
        @Entry("Settings:Appearance-matchSystemTheme", default: true)
        public static var matchSystemTheme: Bool
        
        @Entry("Settings:Appearance-useDarkMode", default: false)
        public static var useDarkMode: Bool
        
        @Entry("Settings:Appearance-mode", default: 0)
        public static var mode: Int
        
        // 1970-1-1 9:00
        @Entry("Settings:Appearance-scheduledLight", default: Date(timeIntervalSince1970: 32400))
        public static var scheduleLight: Date
        
        // 1970-1-1 17:00
        @Entry("Settings:Appearance-scheduledDark", default: Date(timeIntervalSince1970: 61200))
        public static var scheduledDark: Date
        
        @Entry("Settings:Appearance-brightnessThreshold", default: 0.25)
        public static var threshold: CGFloat
    }
}
