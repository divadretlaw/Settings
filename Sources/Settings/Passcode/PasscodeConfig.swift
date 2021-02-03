//
//  PasscodeExtensions.swift
//  Passcode
//
//  Created by David Walter on 28.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif
import KeychainSwift

extension Passcode {
    enum Mode {
        case authentication
        case askCode
        case changeCode
    }
    
    struct Key {
        static let useBiometrics = "Biometrics"
        static let code = "Code"
        private init() {}
        
        static let all = [Key.useBiometrics, Key.code]
    }
    
    enum Value: Hashable {
        case text(String)
        case delete
        case blank
    }
}

extension Passcode {
    public struct Config {
        static var `default`: Config = {
            var config = Config()
            return config
        }()
        
        public var autoBiometrics = true
        
        #if os(iOS)
        public var color: UIColor = .systemBlue
        #elseif os(macOS)
        public var color: NSColor = .systemBlue
        #endif
        
        #if canImport(UIKit)
        public var backgroundBlur: UIBlurEffect.Style = .systemUltraThinMaterial
        public var buttonBlur: UIBlurEffect.Style = .systemThinMaterial
        #endif
    }
}
