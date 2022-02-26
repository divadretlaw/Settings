//
//  BindingWrapper.swift
//  Settings
//
//  Created by David Walter on 19.03.21.
//

import SwiftUI

struct BindingWrapper<T> {
    let hasBinding: Bool
    
    private var bool: Binding<Bool>
    private var identifable: Binding<T?>
    
    init(_ value: Binding<T?>) {
        self.hasBinding = true
        self.bool = .constant(false)
        self.identifable = value
    }
    
    init(_ value: Binding<Bool>) {
        self.hasBinding = true
        self.bool = value
        self.identifable = .constant(nil)
    }
    
    func dismiss() {
        bool.wrappedValue = false
        identifable.wrappedValue = nil
    }
}

extension Bool: Identifiable {
    public var id: String {
        self ? "true" : "false"
    }
}

extension BindingWrapper where T == Bool {
    init() {
        self.hasBinding = false
        self.bool = .constant(false)
        self.identifable = .constant(nil)
    }
}
