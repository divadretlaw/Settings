//
//  AlternativeAppIcons.swift
//  Demo (iOS)
//
//  Created by David Walter on 05.11.21.
//

import Foundation
import SwiftUI
import Settings

enum AlternativeAppIcon: String, AlternateIcon {
    case `default`
    case blue
    
    var id: String { rawValue }
    
    var alternateIconName: String? {
        switch self {
        case .blue:
            return "Blue"
        default:
            return nil
        }
    }
    
    var preview: Image {
        switch self {
        case .blue:
            return Image("BluePreview")
        default:
            return Image("Default")
        }
    }
    
    var title: String {
        switch self {
        case .blue:
            return "Blue"
        default:
            return "Default"
        }
    }
    
    var subtitle: String? {
        return nil
    }
}
