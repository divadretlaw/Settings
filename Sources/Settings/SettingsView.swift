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
    
//    @Binding private var showSettingsBool: Bool
//    @Binding private var showSettingsIdentifable: T?
    @ObservedObject private var viewModel: SettingsViewModel
    
    public var body: some View {
        NavigationView {
            Form {
                content()
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle(self.title)
            .navigationBarItems(trailing: NavBarButton(action: {
                self.viewModel.dismiss()
//                self.showSettingsBool = false
//                self.showSettingsIdentifable = nil
            }, text: Text("Done".localized())))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    public init(showSettings: Binding<T?>,
                @ViewBuilder content: @escaping () -> Content) {
//        self._showSettingsBool = .constant(false)
//        self._showSettingsIdentifable = showSettings
        self.content = content
        self.viewModel = SettingsViewModel(bool: .constant(false), identifiable: showSettings as? Binding<AnyObject?>)
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
//        self._showSettingsBool = showSettings
//        self._showSettingsIdentifable = .constant(nil)
        self.content = content
        self.viewModel = SettingsViewModel(bool: showSettings, identifiable: .constant(nil))
    }
}

class SettingsViewModel: ObservableObject {
    static var shared: SettingsViewModel?
    
    @Binding private var showSettingsBool: Bool
    @Binding private var showSettingsIdentifable: AnyObject?
    
    init(bool: Binding<Bool>, identifiable: Binding<AnyObject?>?) {
        self._showSettingsBool = bool
        self._showSettingsIdentifable = identifiable ?? .constant(nil)
        
        SettingsViewModel.shared = self
    }
    
    func dismiss() {
        self.showSettingsBool = false
        self.showSettingsIdentifable = nil
        
        SettingsViewModel.shared = nil
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
