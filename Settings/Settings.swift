//
//  Settings.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import Foundation

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
    public static var shared = Configuration(mailOptions: MFMailView.Options(toRecipients: nil,
                                                                             ccRecipients: nil,
                                                                             bccRecipients: nil,
                                                                             subject: nil,
                                                                             messageBody: nil))
    
    var mailOptions: MFMailView.Options
}

public struct Appearance {
    @Entry("Settings:Appearance-matchSystemTheme", default: true)
    public static var matchSystemTheme: Bool
    
    @Entry("Settings:Appearance-useDarkMode", default: false)
    public static var useDarkMode: Bool
}
