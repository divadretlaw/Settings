//
//  Passcode.swift
//  Passcode
//
//  Created by David Walter on 28.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//


import SwiftUI
import LocalAuthentication
import KeychainSwift

#if canImport(UIKit)
import UIKit
#endif

public class Passcode {
    public static var shared = Passcode()
    
    public var config = Config()
    
    var biometrics: LABiometryType
    let keychain = KeychainSwift(keyPrefix: "[Passcode] ")
    var foreground: Bool
    var inProgress: Bool
    
    weak var current: ViewModel?
    
    init() {
        self.foreground = true
        self.inProgress = false
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            self.biometrics = context.biometryType
        } else {
            self.biometrics = .none
        }
        
        #if canImport(UIKit)
        NotificationCenter.default.addObserver(self, selector: #selector(self.willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        #endif
    }
    
    // MARK: - Passcode management
    
    func set(code: String) -> Bool {
        return keychain.set(code, forKey: Key.code)
    }
    
    func getCode() -> String? {
        return keychain.get(Key.code)
    }
    
    func hasCode() -> Bool {
        guard let code = getCode() else { return false }
        return !code.isEmpty
    }
    
    func deleteCode() -> Bool {
        return keychain.delete(Key.code)
    }
    
    func set(biometrics: Bool) -> Bool {
        return keychain.set(biometrics, forKey: Key.useBiometrics)
    }
    
    func getBiometrics() -> Bool {
        return keychain.getBool(Key.useBiometrics) == true
    }
    
    // MARK: -
    public func authenticate(animated: Bool = true) {
        guard hasCode() else { return }
        self.current = showPasscode(.authentication, animated: animated, completion: { _ in })
    }
    
    public func askCode(animated: Bool = true, completion: @escaping (Bool) -> Void) {
        guard hasCode() else {
            completion(true)
            return
        }
        showPasscode(.askCode, animated: animated, completion: completion)
    }
    
    public func changeCode(animated: Bool = true, completion: @escaping (Bool) -> Void) {
        showPasscode(.changeCode, animated: animated, completion: completion)
    }
    
    @discardableResult
    private func showPasscode(_ mode: Passcode.Mode, animated flag: Bool = true, completion: @escaping (Bool) -> Void) -> ViewModel? {
        guard inProgress == false else { return nil }
        self.inProgress = true
        
        let host = HostingController(rootView: AnyView(EmptyView()))
        #if os(iOS)
        host.view.backgroundColor = .clear
        host.modalPresentationStyle = .overFullScreen
        #endif
        
        let viewModel = ViewModel(host: host, mode: mode, completion: completion)
        host.rootView = AnyView(PasscodeView(viewModel: viewModel))
        let window = Application.shared.rootWindow
        
        Settings.Appearance.Manager.shared.apply(on: host)
        Settings.Appearance.Manager.shared.apply(on: window)

        #if os(iOS)
        window?.rootViewController?.topViewController()?.present(host, animated: flag)
        #elseif os(macOS)
        window?.contentViewController?.presentAsSheet(host)
        #endif
        return viewModel
    }
    
    // MARK: - NofificationCenter
    
    @objc func willEnterForeground() {
        self.foreground = true
        guard hasCode() else { return }
        if config.autoBiometrics, getBiometrics() {
            self.current?.biometrics()
        }
    }
    
    @objc func didEnterBackground() {
        self.foreground = false
        guard hasCode() else { return }
        self.authenticate(animated: false)
    }
}
