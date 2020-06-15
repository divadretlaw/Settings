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
extension Settings.AppearanceView {
    class ViewModel: ObservableObject {
        @Published var matchSystemTheme: Bool {
            didSet {
                Settings.Appearance.matchSystemTheme = matchSystemTheme
                UIApplication.shared.updateAppearance()
            }
        }
        @Published var useDarkMode: Bool {
            didSet {
                Settings.Appearance.useDarkMode = useDarkMode
                UIApplication.shared.updateAppearance()
            }
        }
        
        init() {
            self.matchSystemTheme = Settings.Appearance.matchSystemTheme
            self.useDarkMode = Settings.Appearance.useDarkMode
            NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: self, queue: nil) { notification in
                print("notification")
            }
        }
        
        func resetAll() {
            guard let identifier = Bundle.main.bundleIdentifier else { return }
            UserDefaults.standard.removePersistentDomain(forName: identifier)
            
            self.matchSystemTheme = Settings.Appearance.matchSystemTheme
            self.useDarkMode = Settings.Appearance.useDarkMode
        }
    }
    
}

#if DEBUG
struct SettingsAppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Settings.AppearanceView()
        }.listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
    }
}
#endif
