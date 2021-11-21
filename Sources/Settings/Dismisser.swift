//
//  Dismisser.swift
//  Settings
//
//  Created by David Walter on 19.03.21.
//

import SwiftUI

class Dismisser: ObservableObject {
    static var shared: Dismisser?

    @Published var shouldDismiss: Bool = false

    init(empty: Bool = false) {
        guard !empty else { return }
        Dismisser.shared = self
    }

    func dismiss() {
        shouldDismiss = true
        Dismisser.shared = nil
    }

    static func navigationBarButton() -> some View {
        return NavBarButton(action: {
            Dismisser.shared?.dismiss()
        }, text: Text("common.done".localized()))
    }
}

extension View {
    public func settingsDismissable() -> some View {
       return dismissable()
    }
    
    @ViewBuilder
    func dismissable() -> some View {
        #if os(iOS)
        if #available(iOS 14, *) {
            self.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if Dismisser.shared != nil {
                        Dismisser.navigationBarButton()
                    }
                }
            }
        } else if Dismisser.shared != nil {
            self.navigationBarItems(trailing: Dismisser.navigationBarButton())
        } else {
            self
        }
        #else
        self.toolbar {
            if Dismisser.shared != nil {
                Dismisser.navigationBarButton()
            }
        }
        #endif
    }
}
