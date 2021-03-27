//
//  Log.swift
//  Settings
//
//  Created by David Walter on 27.03.21.
//

import Foundation

func log(_ messages: String...) {
    #if DEBUG
    print(messages)
    #endif
}
