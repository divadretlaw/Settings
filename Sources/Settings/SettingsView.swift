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
    
    @Binding private var showSettingsBool: Bool
    @Binding private var showSettingsIdentifable: T?
    @ObservedObject private var dismisser: Dismisser
    
    #if os(iOS)
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
            }, text: Text("Done".localized())))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(dismisser.$shouldDismiss) { value in
            if value {
                self.showSettingsBool = false
                self.showSettingsIdentifable = nil
            }
        }
    }
    #else
    public var body: some View {
        NavigationView {
            Form {
                content()
            }
            .navigationTitle(self.title)
        }
        .onReceive(dismisser.$shouldDismiss) { value in
            if value {
                self.showSettingsBool = false
                self.showSettingsIdentifable = nil
            }
        }
    }
    #endif
    
    public init(showSettings: Binding<T?>,
                @ViewBuilder content: @escaping () -> Content) {
        self._showSettingsBool = .constant(false)
        self._showSettingsIdentifable = showSettings
        self.content = content
        self.dismisser = Dismisser()
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
        self.dismisser = Dismisser()
    }
}

class Dismisser: ObservableObject {
    static var shared: Dismisser?
    
    @Published var shouldDismiss: Bool = false
    
    init() {
        Dismisser.shared = self
    }
    
    func dismiss() {
        shouldDismiss = true
        Dismisser.shared = nil
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
