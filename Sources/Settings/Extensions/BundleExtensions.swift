//
//  BundleExtensions.swift
//  
//
//  Created by David Walter on 06.02.21.
//

import Foundation
import SwiftUI

extension Bundle {
    public var icon: UIImage? {
        guard let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let highestResolution = iconFiles.last else {
            return nil
        }
        return UIImage(named: highestResolution)
    }
}
