//
//  File.swift
//  
//
//  Created by David Walter on 28.12.20.
//

import Foundation

extension Settings.InfoView {
    class ViewModel: ObservableObject {
        var bundle: Bundle
        
        init(bundle: Bundle = Bundle.main) {
            self.bundle = bundle
        }
        
        func value(for key: InfoPlistKey) -> String {
            guard let infoDict = bundle.infoDictionary,
                  let value = infoDict[key.rawValue] as? String else {
                return ""
            }
            return value
        }
    }
}
