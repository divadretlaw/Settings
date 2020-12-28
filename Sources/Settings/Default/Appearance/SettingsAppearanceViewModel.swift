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
        
        init() {
            self.matchSystemTheme = Settings.Appearance.matchSystemTheme
            self.useDarkMode = Settings.Appearance.useDarkMode
            NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: self, queue: nil) { _ in
                
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
