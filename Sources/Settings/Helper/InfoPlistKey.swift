//
//  InfoPlistKey.swift
//  Settings
//
//  Created by David Walter on 26.12.20.
//

import Foundation

public enum InfoPlistKey: Hashable {
    case version
    case buildNumber
    case appName
    case sdkVersion
    case custom(key: String)
    
    var rawValue: String {
        switch self {
        case .version:
            return "CFBundleShortVersionString"
        case .buildNumber:
            return "CFBundleVersion"
        case .appName:
            return "CFBundleName"
        case .sdkVersion:
            return "DTSDKName"
        case let .custom(key):
            return key
        }
    }
}
