//
//  SettingsView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

public struct SettingsView<T, Content>: View where T: Identifiable, Content: View {
    var title: String = "Settings".localized()
    var content: () -> Content

    private var showSettings: BindingWrapper<T>
    @ObservedObject private var dismisser: Dismisser

    #if os(iOS)
    public var body: some View {
        NavigationView {
            Form {
                content()
                    .animation(nil)
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle(self.title)
            .dismissable()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(dismisser.$shouldDismiss) { value in
            if value {
                self.showSettings.dismiss()
            }
        }
    }
    #else
    public var body: some View {
        NavigationView {
            Form {
                content()
                    .animation(nil)
            }
            .navigationTitle(self.title)
        }
        .onReceive(dismisser.$shouldDismiss) { value in
            if value {
                self.showSettings.dismiss()
            }
        }
    }
    #endif

    public init(showSettings: Binding<T?>,
                @ViewBuilder content: @escaping () -> Content) {
        self.showSettings = BindingWrapper(showSettings)
        self.content = content
        self.dismisser = Dismisser()
    }
}

public extension SettingsView where T == Bool {
    init(showSettings: Binding<Bool>,
         @ViewBuilder content: @escaping () -> Content) {
        self.showSettings = BindingWrapper(showSettings)
        self.content = content
        self.dismisser = Dismisser()
    }
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.showSettings = BindingWrapper<Bool>()
        self.content = content
        self.dismisser = Dismisser(empty: true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettings: .constant(true), content: {
            Settings.AppearanceView()
            #if os(iOS)
            Settings.SupportView()
            #endif
            Settings.ResetView()
        })
    }
}
