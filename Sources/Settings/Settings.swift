import Foundation
import UIKit

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
        public static var shared = Configuration(mailOptions: MFMailView.Options(toRecipients: nil,
                                                                                 ccRecipients: nil,
                                                                                 bccRecipients: nil,
                                                                                 subject: nil,
                                                                                 messageBody: nil))
        
        public var mailOptions: MFMailView.Options
        
        public init(mailOptions: MFMailView.Options) {
            self.mailOptions = mailOptions
        }
    }
    
    public static func apply(on window: UIWindow?) {
        Settings.Appearance.apply(on: window)
    }
    
    public static func apply() {
        UIApplication.shared.windows.forEach { apply(on: $0) }
        Passcode.shared.authenticate()
    }
}

public extension Settings {
    struct Appearance {
        @Entry("Settings:Appearance-matchSystemTheme", default: true)
        public static var matchSystemTheme: Bool
        
        @Entry("Settings:Appearance-useDarkMode", default: false)
        public static var useDarkMode: Bool
        
        public static func apply(on viewController: UIViewController?) {
            if !Settings.Appearance.matchSystemTheme {
                viewController?.overrideUserInterfaceStyle = Settings.Appearance.useDarkMode ? .dark : .light
            }
        }
        
        public static func apply(on window: UIWindow?) {
            if !Settings.Appearance.matchSystemTheme {
                window?.overrideUserInterfaceStyle = Settings.Appearance.useDarkMode ? .dark : .light
            }
        }
        
        public static func apply() {
            UIApplication.shared.windows.forEach { apply(on: $0) }
        }
    }
}
