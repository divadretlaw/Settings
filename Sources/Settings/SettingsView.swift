//
//  SettingsView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

public typealias SettingsView = Settings.SettingsView

extension Settings {
    public struct SettingsView<T, Content>: View where T: Identifiable, Content: View {
        var title = Text("settings.title".localized())
        var displayMode: NavigationBarItem.TitleDisplayMode = .automatic
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
                .navigationBarTitle(self.title, displayMode: displayMode)
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
            TabView {
                content()
                    .animation(nil)
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
        
        // MARK: Modifier
        
        public func navigationTitle(_ title: String) -> Self {
            var view = self
            view.title = Text(title)
            return view
        }
        
        public func navigationTitle(_ title: Text) -> Self {
            var view = self
            view.title = title
            return view
        }
        
        public func navigationBarTitleDisplayMode(_ displayMode: NavigationBarItem.TitleDisplayMode) -> Self {
            var view = self
            view.displayMode = displayMode
            return view
        }
    }
}

extension Settings.SettingsView where T == Bool {
    public init(showSettings: Binding<Bool>,
                @ViewBuilder content: @escaping () -> Content) {
        self.showSettings = BindingWrapper(showSettings)
        self.content = content
        self.dismisser = Dismisser()
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.showSettings = BindingWrapper<Bool>()
        self.content = content
        self.dismisser = Dismisser(empty: true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    #if os(iOS)
    static var previews: some View {
        SettingsView(showSettings: .constant(true)) {
            Settings.AppearanceView()
            Settings.SupportView()
            Settings.ResetView()
        }
    }
    #else
    static var previews: some View {
        SettingsView(showSettings: .constant(true)) {
            VStack {
                Settings.AppearanceView()
                Settings.ResetView()
            }
            .tabItem {
                Text("General")
            }
        }
        .padding()
    }
    #endif
}
