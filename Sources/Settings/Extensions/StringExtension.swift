//
//  StringExtension.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import Foundation
#if !os(macOS)
import UIKit
#endif

extension String {
    static var done: String {
        #if !os(macOS)
        return UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil).title ?? "Done"
        #else
        return "Done"
        #endif
    }
}
