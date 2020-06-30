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
        @State var isOn: Bool
        @State var showEdit = false
        
        public var body: some View {
            Section(header: self.headerView) {
                Button(action: {
                    if self.isOn {
                        Passcode.shared.askCode { self.showEdit = $0 }
                    } else {
                        self.showEdit = true
                    }
                }, label: {
                    ZStack {
                        NavigationLink(destination: PasscodeEditView(), isActive: $showEdit, label: { EmptyView() })
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
                })
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
            self._isOn = State(initialValue: Passcode.shared.getCode() != nil)
        }
        
    }
    
    struct PasscodeEditView: View {
        @ObservedObject var viewModel: ViewModel
        private var showHeader: Bool
        
        var body: some View {
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
            .navigationBarTitle("Passcode".localized())
            .navigationBarItems(trailing: NavBarButton(action: {
                SettingsViewModel.shared?.dismiss()
            }, text: Text("Done".localized())))
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
                switch (oldValue, isOn) {
                case (false, true):
                    setCode()
                case (true, false):
                    deleteCode()
                default:
                    return
                }
            }
        }
        @Published var isBiometricsOn: Bool {
            didSet {
                if !Passcode.shared.set(biometrics: isBiometricsOn) {
                    isBiometricsOn = oldValue
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
        
        func deleteCode() {
            self.isOn = !Passcode.shared.deleteCode()
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
