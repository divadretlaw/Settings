//
//  SettingsPasscodeEditViewModel.swift
//  Settings
//
//  Created by David Walter on 28.12.20.
//

#if os(iOS)
import Foundation

extension Settings.PasscodeEditView {
    class ViewModel: ObservableObject {
        @Published var isBiometricsOn: Bool {
            didSet {
                if !Passcode.shared.set(biometrics: isBiometricsOn) {
                    isBiometricsOn = oldValue
                }
            }
        }
        
        init() {
            self.isBiometricsOn = Passcode.shared.getBiometrics()
        }
        
        func changeCode() {
            Passcode.shared.changeCode { _ in
            }
        }
        
        func deleteCode() -> Bool {
            Passcode.shared.deleteCode()
        }
    }
}
#endif
