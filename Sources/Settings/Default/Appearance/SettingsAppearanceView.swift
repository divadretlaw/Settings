//
//  SettingsAppearanceView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

extension Settings {
    public struct AppearanceSection: View, HeaderView {
        public var header = (title: "appearance.title", show: true)
        
        public var body: some View {
            Section(header: self.headerView) {
                AppearanceView()
            }
            .animation(.default)
        }
        
        public init() {
            
        }
    }
        
    public struct AppearanceView: View {
        @StateObject private var viewModel = Appearance.ViewModel()
        
        public var body: some View {
            Toggle(isOn: self.$viewModel.matchSystemTheme) {
                Text("appearance.simple.system".localized())
            }
            
            if !viewModel.matchSystemTheme {
                Toggle(isOn: self.$viewModel.useDarkMode) {
                    Text("appearance.simple.dark".localized())
                }
                .transition(.slide)
            }
        }
        
        public init() {
            
        }
    }
}

struct SettingsAppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Settings.AppearanceSection()
        }
    }
}
