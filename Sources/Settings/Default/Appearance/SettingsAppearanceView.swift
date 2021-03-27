//
//  SettingsAppearanceView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

extension Settings {
    public struct AppearanceView: View, HeaderView {
        var header = (title: "Appearance", show: true)
        @ObservedObject var viewModel: Appearance.ViewModel
        
        public var body: some View {
            Section(header: self.headerView) {
                Toggle(isOn: self.$viewModel.matchSystemTheme) {
                    Text("Match System Theme".localized())
                }
                if !viewModel.matchSystemTheme {
                    Toggle(isOn: self.$viewModel.useDarkMode) {
                        Text("Dark Mode".localized())
                    }.transition(.slide)
                }
            }.animation(.default)
        }
        
        public init() {
            self.viewModel = Appearance.ViewModel()
        }
    }
}

struct SettingsAppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Settings.AppearanceView()
        }
    }
}
