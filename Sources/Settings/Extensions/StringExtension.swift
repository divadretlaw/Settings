//
//  StringExtension.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static var done: String {
        return UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil).title ?? "Done"
    }
}
