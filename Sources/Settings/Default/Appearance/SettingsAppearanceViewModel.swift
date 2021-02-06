//
//  SettingsAppearanceViewModel.swift
//  
//
//  Created by David Walter on 28.12.20.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

extension Settings.AppearanceView {
    class ViewModel: ObservableObject {
        enum Mode: Int, Identifiable {
            case manual
            case scheduled
            case automatically
            
            var id: Int { self.rawValue }
        }
        
        @Published var matchSystemTheme: Bool {
            didSet {
                Settings.Appearance.matchSystemTheme = matchSystemTheme
                Application.shared.updateAppearance()
            }
        }
        
        @Published var useDarkMode: Bool {
            didSet {
                Settings.Appearance.useDarkMode = useDarkMode
                Application.shared.updateAppearance()
            }
        }
        
        @Published var mode: Mode {
            didSet {
                Settings.Appearance.mode = mode.rawValue
                Application.shared.updateAppearance()
            }
        }
        
        init() {
            self.matchSystemTheme = Settings.Appearance.matchSystemTheme
            self.useDarkMode = Settings.Appearance.useDarkMode
            self.mode = Mode(rawValue: Settings.Appearance.mode) ?? .manual
        }
        
        func resetAll() {
            guard let identifier = Bundle.main.bundleIdentifier else { return }
            Settings.userDefaults.removePersistentDomain(forName: identifier)
            
            self.matchSystemTheme = Settings.Appearance.matchSystemTheme
            self.useDarkMode = Settings.Appearance.useDarkMode
            self.mode = Mode(rawValue: Settings.Appearance.mode) ?? .manual
        }
    }
}
