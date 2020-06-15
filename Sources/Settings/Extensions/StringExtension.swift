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

fileprivate class Localizable {
    
}

extension String {
    func localized(comment: String = "") -> String {
        let bundle = Bundle.main.path(forResource: "Settings", ofType: "strings") != nil
            ? Bundle.main : Bundle(for: Localizable.self)
        
        return NSLocalizedString(self, tableName: "Settings", bundle: bundle, comment: comment)
    }
}
