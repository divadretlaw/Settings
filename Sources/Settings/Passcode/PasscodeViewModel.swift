//
//  PasscodeViewModel.swift
//  Passcode
//
//  Created by David Walter on 27.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

extension Passcode {
    class ViewModel: ObservableObject {
        @Published var text: String
        var length: Int
        @Published var wrongCodeCount = 0
        
        let host: UIViewController
        let mode: Passcode.Mode
        var completion: (Bool) -> Void
        
        var newCode: String?
        var hasNewCode = false
        
        init(host: UIViewController, mode: Passcode.Mode, completion: @escaping (Bool) -> Void) {
            self.host = host
            self.mode = mode
            self.completion = completion
            
            self.text = ""
            if mode == .changeCode {
                self.length = 4
            } else {
                self.length = Passcode.shared.getCode()?.count ?? 0
            }
            self.wrongCodeCount = 0
            
            if mode == .authentication, Passcode.shared.foreground, Passcode.shared.getBiometrics() {
                biometrics()
            }
        }
        
        func add(_ value: Value) {
            switch value {
            case .text(let character):
                guard text.count < self.length else { return }
                text.append(character)
            case .delete:
                text = String(text.dropLast())
            case .blank:
                return
            }
            
            if mode == .changeCode {
                self.checkNewCode()
            } else {
                self.checkCode()
            }
        }
        
        func biometrics() {
            let context = LAContext()
            var error: NSError?
            
            guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else { return }
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: Passcode.shared.biometrics.reason) { success, error in
                if success {
                    self.dismiss(success: true)
                } else {
                    print(error?.localizedDescription ?? "[Settings.Passcode] Unknown Error occured")
                }
            }
        }
        
        func cancel() {
            guard mode != .authentication else { return }
            self.dismiss(success: false)
        }
        
        private func checkCode() {
            guard text.count >= length else { return }
            
            if Passcode.shared.getCode() == text {
                self.dismiss(success: true)
            } else {
                wrongCodeCount += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    self?.text = ""
                }
            }
        }
        
        private func checkNewCode() {
            guard text.count >= length else { return }
            
            guard let newCode = newCode else {
                self.newCode = text
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                    self?.text = ""
                    self?.hasNewCode = true
                }
                return
            }
            
            if newCode == text {
                self.dismiss(success: Passcode.shared.set(code: newCode))
            } else {
                wrongCodeCount += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    self?.text = ""
                }
            }
        }
        
        private func dismiss(success: Bool) {
            Passcode.shared.inProgress = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                self?.completion(success)
                self?.host.dismiss(animated: true, completion: nil)
            }
        }
    }
}
