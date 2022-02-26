//
//  SettingsAppearanceViewModel.swift
//  Settings
//
//  Created by David Walter on 28.12.20.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

extension Settings.Appearance {
    class ViewModel: ObservableObject {
        @Published var matchSystemTheme: Bool {
            didSet {
                Settings.Appearance.matchSystemTheme = matchSystemTheme
                Settings.Appearance.Manager.shared.apply()
            }
        }
        
        @Published var useDarkMode: Bool {
            didSet {
                Settings.Appearance.useDarkMode = useDarkMode
                Settings.Appearance.Manager.shared.apply()
            }
        }
        
        @Published var mode: Mode {
            didSet {
                Settings.Appearance.mode = mode.rawValue
                Settings.Appearance.Manager.shared.apply()
            }
        }
        
        @Published var threshold: CGFloat {
            didSet {
                Settings.Appearance.threshold = threshold
                Settings.Appearance.Manager.shared.apply()
            }
        }
        
        init() {
            self.matchSystemTheme = Settings.Appearance.matchSystemTheme
            self.useDarkMode = Settings.Appearance.useDarkMode
            self.mode = Mode(rawValue: Settings.Appearance.mode) ?? .manual
            self.threshold = Settings.Appearance.threshold
        }
        
        func resetAll() {
            guard let identifier = Bundle.main.bundleIdentifier else { return }
            Settings.userDefaults.removePersistentDomain(forName: identifier)
            
            matchSystemTheme = Settings.Appearance.matchSystemTheme
            useDarkMode = Settings.Appearance.useDarkMode
            mode = Mode(rawValue: Settings.Appearance.mode) ?? .manual
        }
    }
}
