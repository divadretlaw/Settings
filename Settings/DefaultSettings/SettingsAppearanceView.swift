//
//  SettingsAppearanceView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

public struct SettingsAppearanceView: View {
    @ObservedObject var viewModel: ViewModel
    private var header: String?
    private var matchSystemTitle: String
    private var darkModeTitle: String
    
    public var body: some View {
        Section(header: self.headerView) {
            Toggle(isOn: self.$viewModel.matchSystemTheme) {
                Text(self.matchSystemTitle)
            }
            if !viewModel.matchSystemTheme {
                Toggle(isOn: self.$viewModel.useDarkMode) {
                    Text(self.darkModeTitle)
                }.transition(.slide)
            }
        }.animation(.default)
    }
    
    var headerView: some View {
        Group {
            if header == nil {
                EmptyView()
            } else {
                Text(header ?? "")
            }
        }
    }
    
    public init(header: String? = "Appearance",
         matchSystemTitle: String = "Match System Theme",
         darkModeTitle: String = "Dark Mode") {
        self.header = header
        self.matchSystemTitle = matchSystemTitle
        self.darkModeTitle = darkModeTitle
        self.viewModel = ViewModel()
    }
}

extension SettingsAppearanceView {
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
            SettingsAppearanceView()
        }.listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
    }
}
#endif
