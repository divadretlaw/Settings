//
//  SettingsAppearanceView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

extension Settings {
    public struct AppearanceView: View {
        @ObservedObject var viewModel: ViewModel
        private var showHeader: Bool
        
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
        
        var headerView: some View {
            Group {
                if showHeader {
                    Text("Appearance".localized())
                } else {
                    EmptyView()
                }
            }
        }
        
        public init(showHeader: Bool = true) {
            self.showHeader = showHeader
            self.viewModel = ViewModel()
        }
    }
}

#if DEBUG
struct SettingsAppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Settings.AppearanceView()
        }.listStyle(GroupedListStyle())
    }
}
#endif
