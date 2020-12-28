//
//  TypeAliases.swift
//  
//
//  Created by David Walter on 28.12.20.
//

import Foundation
import SwiftUI

#if os(iOS)
import UIKit

typealias Application = UIApplication

typealias ViewController = UIViewController
typealias HostingController = UIHostingController

typealias Font = UIFont
#elseif os(macOS)
import AppKit

typealias Application = NSApplication

typealias ViewController = NSViewController
typealias HostingController = NSHostingController

typealias Font = NSFont

extension NSColor {
    static var label: NSColor {
        return NSColor.labelColor
    }
}
#endif
