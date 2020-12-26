//
//  File.swift
//  
//
//  Created by David Walter on 26.12.20.
//

import Foundation

enum InfoPlistKey: Hashable {
    case version
    case buildNumber
    case appName
    case sdkVersion
    case custom(title: String, key: String)
    
    var title: String {
        switch self {
        case .version:
            return "Version"
        case .buildNumber:
            return "Build Number"
        case .appName:
            return "App Name"
        case .sdkVersion:
            return "SDK Version"
        case .custom(let title, _):
            return title
        }
    }
    
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
        case .custom(_, let key):
            return key
        }
    }
}
