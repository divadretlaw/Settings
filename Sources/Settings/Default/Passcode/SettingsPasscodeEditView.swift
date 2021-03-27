//
//  SettingsPasscodeEditView.swift
//  
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
            .dismissable()
        }
        
        init(onChange: @escaping (Bool) -> Void) {
            self.onChange = onChange
            viewModel = ViewModel()
        }
    }
}
#endif
