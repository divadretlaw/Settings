//
//  SettingsResetViewModel.swift
//  
//
//  Created by David Walter on 28.12.20.
//

import Foundation

extension Settings.ResetView {
    class ViewModel: ObservableObject {
        func resetAll() {
            deleteUserDefaults()
            deletePasscode()
        }
        
        func deletePasscode() {
            Passcode.Key.all.forEach {
                Passcode.shared.keychain.delete($0)
            }
        }
        
        func deleteUserDefaults() {
            guard let identifier = Bundle.main.bundleIdentifier else { return }
            UserDefaults.standard.removePersistentDomain(forName: identifier)
        }
    }
}
