//
//  LABiometryTypeExtensions.swift
//  Passcode
//
//  Created by David Walter on 28.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import Foundation
import LocalAuthentication

extension LABiometryType {
    var description: String {
        switch self {
        case .touchID:
            return "Touch ID"
        case .faceID:
            return "Face ID"
        default:
            return ""
        }
    }
    
    var reason: String {
        switch self {
        case .touchID:
            return "biometricsReasonTouchID"
        case .faceID:
            return "biometricsReasonFaceID"
        default:
            return ""
        }
    }
}
