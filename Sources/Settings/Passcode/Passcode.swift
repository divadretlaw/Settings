//
//  Passcode.swift
//  Passcode
//
//  Created by David Walter on 28.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import UIKit
import SwiftUI
import LocalAuthentication
import KeychainSwift

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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    // MARK: - Passcode management
    
    func set(code: String) -> Bool {
        return keychain.set(code, forKey: Key.code)
    }
    
    func getCode() -> String? {
        return keychain.get(Key.code)
    }
    
    func set(biometrics: Bool) -> Bool {
        return keychain.set(biometrics, forKey: Key.useBiometrics)
    }
    
    func getBiometrics() -> Bool {
        return keychain.getBool(Key.useBiometrics) == true
    }
    
    // MARK: -
    
    public func authenticate(animated: Bool = true) {
        guard inProgress == false, getCode() != nil else { return }
        self.inProgress = true
        
        let host = UIHostingController(rootView: AnyView(EmptyView()))
        host.view.backgroundColor = .clear
        let viewModel = ViewModel(host: host,
                                  mode: .authentication,
                                  completion: { _ in })
        self.current = viewModel
        host.rootView = AnyView(PasscodeView(viewModel: viewModel))
        host.modalPresentationStyle = .overFullScreen
        
        let window =  UIApplication.shared.windows.last
        Settings.Appearance.apply(on: window)
        Settings.Appearance.apply(on: host)
        window?.rootViewController?.present(host,
                                            animated: animated,
                                            completion: nil)
    }
    
    public func askCode(animated: Bool = true, completion: @escaping (Bool) -> Void) {
        guard inProgress == false, getCode() != nil else { return }
        self.inProgress = true
        
        let host = UIHostingController(rootView: AnyView(EmptyView()))
        host.view.backgroundColor = .clear
        let viewModel = ViewModel(host: host,
                                  mode: .askCode,
                                  completion: completion)
        host.rootView = AnyView(PasscodeView(viewModel: viewModel))
        host.modalPresentationStyle = .overFullScreen
        let window =  UIApplication.shared.windows.last
        Settings.Appearance.apply(on: window)
        Settings.Appearance.apply(on: host)
        
        window?.rootViewController?.present(host,
                                            animated: animated,
                                            completion: nil)
    }
    
    public func changeCode(animated: Bool = true, completion: @escaping (Bool) -> Void) {
        guard inProgress == false else { return }
        self.inProgress = true
        
        let host = UIHostingController(rootView: AnyView(EmptyView()))
        host.view.backgroundColor = .clear
        let viewModel = ViewModel(host: host,
                                  mode: .changeCode,
                                  completion: completion)
        host.rootView = AnyView(PasscodeView(viewModel: viewModel))
        host.modalPresentationStyle = .overFullScreen
        let window =  UIApplication.shared.windows.last
        Settings.Appearance.apply(on: window)
        Settings.Appearance.apply(on: host)
        window?.rootViewController?.present(host,
                                            animated: animated,
                                            completion: nil)
    }
    
    // MARK: - NofificationCenter
    
    @objc func willEnterForeground() {
        self.foreground = true
        if config.autoBiometrics, getBiometrics() {
            self.current?.biometrics()
        }
    }
    
    @objc func didEnterBackground() {
        self.foreground = false
        guard getCode() != nil else { return }
        self.authenticate()
    }
}
