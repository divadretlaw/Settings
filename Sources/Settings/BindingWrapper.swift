//
//  BindingWrapper.swift
//  Settings
//
//  Created by David Walter on 19.03.21.
//

import SwiftUI

struct BindingWrapper<T> {
    let hasBinding: Bool
    
    @Binding private var bool: Bool
    @Binding private var identifable: T?
    
    init(_ value: Binding<T?>) {
        self.hasBinding = true
        self._bool = .constant(false)
        self._identifable = value
    }
    
    init(_ value: Binding<Bool>) {
        self.hasBinding = true
        self._bool = value
        self._identifable = .constant(nil)
    }
    
    init() {
        self.hasBinding = false
        self._bool = .constant(false)
        self._identifable = .constant(nil)
    }
    
    func dismiss() {
        self.bool = false
        self.identifable = nil
    }
}

extension Bool: Identifiable {
   public var id: String {
       return self ? "true" : "false"
   }
}
