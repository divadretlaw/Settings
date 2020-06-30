//
//  PasscodeExtensions.swift
//  Passcode
//
//  Created by David Walter on 28.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import Foundation
import UIKit
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
    
    enum Value {
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
        public var color: UIColor = .systemBlue
    }
}
