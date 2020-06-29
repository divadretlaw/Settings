//
//  SettingsPasscodeView.swift
//  Settings
//
//  Created by David Walter on 28.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

extension Settings {
    public struct PasscodeView: View {
        private var showHeader: Bool
        @State var isOn: Bool?
        
        public var body: some View {
            Section(header: self.headerView) {
                NavigationLink(destination: PasscodeEditView()) {
                    HStack {
                        Text("Passcode".localized())
                        Spacer()
                        if isOn == true {
                            Text("On".localized())
                                .foregroundColor(Color.secondary)
                        } else if isOn == false {
                            Text("Off".localized())
                                .foregroundColor(Color.secondary)
                        } else {
                            EmptyView()
                        }
                    }
                }
            }.onAppear {
                self.isOn = Passcode.shared.getCode() != nil
            }
        }
        
        var headerView: some View {
            Group {
                if showHeader {
                    Text("Passcode".localized())
                } else {
                    EmptyView()
                }
            }
        }
        
        public init(showHeader: Bool = true) {
            self.showHeader = showHeader
        }
        
    }
    
    struct PasscodeEditView: View {
        @ObservedObject var viewModel: ViewModel
        private var showHeader: Bool
        
        var body: some View {
            NavigationView {
                Form {
                        Toggle(isOn: $viewModel.isOn) {
                            Text("Passcode".localized())
                        }
                        if viewModel.isOn {
                            Group {
                                Button(action: {
                                    self.viewModel.changeCode()
                                }, label: {
                                    Text("Change Passcode")
                                })
                                if Passcode.shared.biometrics != .none {
                                    Toggle(isOn: $viewModel.isBiometricsOn) {
                                        Text(Passcode.shared.biometrics.description)
                                    }
                                }
                            }.transition(.slide)
                        }
                }
                .environment(\.horizontalSizeClass, .regular)
                .animation(.default)
            }
        }
        
        var headerView: some View {
            Group {
                if showHeader {
                    Text("Passcode".localized())
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

extension Settings.PasscodeEditView {
    class ViewModel: ObservableObject {
        @Published var isOn: Bool {
            didSet {
                if oldValue == false {
                    setCode()
                }
            }
        }
        @Published var isBiometricsOn: Bool {
            didSet {
                if !Passcode.shared.set(biometrics: isBiometricsOn) {
                    isBiometricsOn = false
                }
            }
        }
        
        init() {
            self.isOn = Passcode.shared.getCode() != nil
            self.isBiometricsOn = Passcode.shared.getBiometrics()
        }
        
        func setCode() {
            Passcode.shared.changeCode { success in
                if success {
                    self.isOn = true
                } else {
                    self.isOn = false
                }
            }
        }
        
        func changeCode() {
            Passcode.shared.changeCode { _ in
                
            }
        }
    }
}

#if DEBUG
struct SettingsPasscodeView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Settings.PasscodeView()
        }.listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
    }
}
#endif
