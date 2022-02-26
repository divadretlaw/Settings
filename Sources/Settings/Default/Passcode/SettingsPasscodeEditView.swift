//
//  SettingsPasscodeEditView.swift
//  Settings
//
//  Created by David Walter on 28.12.20.
//

#if os(iOS)
import SwiftUI

extension Settings {
    struct PasscodeEditView: View {
        @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        @ObservedObject var viewModel: ViewModel
        var onChange: (Bool) -> Void
        
        var body: some View {
            Form {
                Section {
                    Button {
                        self.viewModel.changeCode()
                    } label: {
                        Text("passcode.change".localized())
                    }
                    
                    if Passcode.shared.biometrics != .none {
                        Toggle(isOn: $viewModel.isBiometricsOn) {
                            Text(Passcode.shared.biometrics.description)
                        }
                    }
                }
                Section {
                    Button {
                        if self.viewModel.deleteCode() {
                            self.onChange(false)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("passcode.delete".localized())
                            .foregroundColor(.red)
                    }
                }
            }
            .environment(\.horizontalSizeClass, .regular)
            .animation(.default)
            .navigationBarTitle("passcode.title".localized())
            .dismissable()
        }
        
        init(onChange: @escaping (Bool) -> Void) {
            self.onChange = onChange
            self.viewModel = ViewModel()
        }
    }
}
#endif
