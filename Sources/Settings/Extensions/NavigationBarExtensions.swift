//
//  NavigationBarExtensions.swift
//  Settings
//
//  Created by David Walter on 19.03.21.
//

import SwiftUI

#if os(iOS)
extension View {
    @ViewBuilder
    public func conditionalNavigationBarItems<L, T>(hasLeading: Bool = true,
                                                    leading: L,
                                                    hasTrailing: Bool = true,
                                                    trailing: T) -> some View where L: View, T: View {
        switch (hasLeading, hasTrailing) {
        case (true, true):
            navigationBarItems(leading: leading,
                               trailing: trailing)
        case (true, false):
            navigationBarItems(leading: leading)
        case (false, true):
            navigationBarItems(trailing: trailing)
        default:
            self
        }
    }
    
    @ViewBuilder
    public func conditionalNavigationBarItems<T>(hasTrailing: Bool = true,
                                                 trailing: T) -> some View where T: View {
        switch hasTrailing {
        case true:
            navigationBarItems(trailing: trailing)
        default:
            self
        }
    }
    
    @ViewBuilder
    public func conditionalNavigationBarItems<L>(hasLeading: Bool = true,
                                                 leading: L) -> some View where L: View {
        switch hasLeading {
        case true:
            navigationBarItems(leading: leading)
        default:
            self
        }
    }
    
    @ViewBuilder
    public func conditionalNavigationBarItems<L, T>(hasLeading: Bool = true,
                                                    leading: () -> L,
                                                    hasTrailing: Bool = true,
                                                    trailing: () -> T) -> some View where L: View, T: View {
        switch (hasLeading, hasTrailing) {
        case (true, true):
            navigationBarItems(leading: leading(),
                               trailing: trailing())
        case (true, false):
            navigationBarItems(leading: leading())
        case (false, true):
            navigationBarItems(trailing: trailing())
        default:
            self
        }
    }
    
    @ViewBuilder
    public func conditionalNavigationBarItems<T>(hasTrailing: Bool = true,
                                                 trailing: () -> T) -> some View where T: View {
        switch hasTrailing {
        case true:
            navigationBarItems(trailing: trailing())
        default:
            self
        }
    }
    
    @ViewBuilder
    public func conditionalNavigationBarItems<L>(hasLeading: Bool = true,
                                                 leading: () -> L) -> some View where L: View {
        switch hasLeading {
        case true:
            navigationBarItems(leading: leading())
        default:
            self
        }
    }
}
#endif
