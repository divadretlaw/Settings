//
//  Unwrap.swift
//  Settings
//
//  Created by David Walter on 05.02.21.
//

import Foundation

func unwrap<T>(_ any: T) -> Any {
    let mirror = Mirror(reflecting: any)
    guard mirror.displayStyle == .optional, let first = mirror.children.first else {
        return format(any)
    }
    
    return format(first.value)
}

func format<T>(_ any: T) -> Any {
    if let data = any as? Data {
        if let unarchived = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) {
            return unarchived
        }
        return String(data: data, encoding: .utf8) ?? data.map { String(format: "%02hhx", $0) }.joined()
    }
    return any
}
