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
                        Passcode.shared.changeCode {
                            self.isOn = $0
                            self.showEdit = $0
                        }
                    }
                }, label: {
                    ZStack {
                        NavigationLink(destination: PasscodeEditView { self.isOn = $0 }, isActive: $showEdit, label: { EmptyView() })
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
            self._isOn = State(initialValue: Passcode.shared.hasCode())
        }
        
    }
    
    struct PasscodeEditView: View {
        @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        @ObservedObject var viewModel: ViewModel
        var onChange: (Bool) -> Void
        
        var body: some View {
            Form {
                Section {
                    Button(action: {
                        self.viewModel.changeCode()
                    }, label: {
                        Text("Change Passcode".localized())
                    })
                    if Passcode.shared.biometrics != .none {
                        Toggle(isOn: $viewModel.isBiometricsOn) {
                            Text(Passcode.shared.biometrics.description)
                        }
                    }
                }
                Section {
                    Button(action: {
                        if self.viewModel.deleteCode() {
                            self.onChange(false)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }, label: {
                        Text("Remove Passcode".localized())
                            .foregroundColor(.red)
                    })
                }
            }
            .environment(\.horizontalSizeClass, .regular)
            .animation(.default)
            .navigationBarTitle("Passcode".localized())
            .navigationBarItems(trailing: NavBarButton(action: {
                Dismisser.shared?.dismiss()
            }, text: Text("Done".localized())))
        }
        
        init(onChange: @escaping (Bool) -> Void) {
            self.onChange = onChange
            viewModel = ViewModel()
        }
    }
}

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
        
        func deleteCode() -> Bool{
            return Passcode.shared.deleteCode()
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
