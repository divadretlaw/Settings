//
//  SettingsView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI
import MessageUI

public struct SettingsView<Content>: View where Content: View {
    var title: String = "Settings"
    var content: () -> Content
    @Binding var showSettings: Bool
    
    public var body: some View {
        NavigationView {
            Form {
                content()
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle(self.title)
            .navigationBarItems(trailing: NavBarButton(action: {
                self.showSettings = false
            }, text: Text(String.done)))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    public init(showSettings: Binding<Bool>,
                @ViewBuilder content: @escaping () -> Content) {
        self._showSettings = showSettings
        self.content = content
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettings: .constant(true), content: {
            SettingsAppearanceView()
            SettingsSupportView()
            SettingsResetView()
        })
    }
}
#endif
