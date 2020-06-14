//
//  SettingsView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

public struct SettingsView<T, Content>: View where T: Identifiable, Content: View {
    var title: String = "Settings"
    var content: () -> Content
    
    @Binding private var showSettingsBool: Bool
    @Binding private var showSettingsIdentifable: T?
    
    public var body: some View {
        NavigationView {
            Form {
                content()
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle(self.title)
            .navigationBarItems(trailing: NavBarButton(action: {
                self.showSettingsBool = false
                self.showSettingsIdentifable = nil
            }, text: Text(String.done)))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    public init(showSettings: Binding<T?>,
                @ViewBuilder content: @escaping () -> Content) {
        self._showSettingsBool = .constant(false)
        self._showSettingsIdentifable = showSettings
        self.content = content
    }
}

extension Bool: Identifiable {
    public var id: String {
        return self ? "true" : "false"
    }
}

extension SettingsView where T == Bool {
    public init(showSettings: Binding<Bool>,
                @ViewBuilder content: @escaping () -> Content) {
        self._showSettingsBool = showSettings
        self._showSettingsIdentifable = .constant(nil)
        self.content = content
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettings: .constant(true), content: {
            Settings.AppearanceView()
            Settings.SupportView()
            Settings.ResetView()
        })
    }
}
#endif
