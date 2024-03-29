//
//  PasscodeView.swift
//  Passcode
//
//  Created by David Walter on 27.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

extension Passcode {
    struct PasscodeView: View {
        @ObservedObject var viewModel: ViewModel
        @State var attempts = 0
        
        var body: some View {
            ZStack {
                #if os(iOS)
                BlurView(style: Passcode.shared.config.backgroundBlur)
                    .edgesIgnoringSafeArea(.all)
                #elseif os(macOS)
                BlurView(mode: .withinWindow)
                #endif
                VStack {
                    Text(viewModel.mode == .changeCode
                        ? "Enter New Passcode".localized()
                        : "Enter Passcode".localized())
                        .font(.title)
                        .padding()
                    Spacer()
                    self.code
                    self.hint
                    self.keypad
                    Spacer()
                    if viewModel.mode == .authentication {
                        self.biometricsButton
                    } else {
                        self.cancelButton
                    }
                }.padding()
            }.onReceive(viewModel.$wrongCodeCount) { count in
                withAnimation(.default) {
                    self.attempts = count
                }
            }
        }
        
        var code: some View {
            CodeView(viewModel: self.viewModel)
                .padding()
                .modifier(Shake(animatableData: CGFloat(attempts)))
                .foregroundColor(Color(Passcode.shared.config.color))
        }
        
        var hint: some View {
            Group {
                if viewModel.mode == .changeCode, viewModel.hasNewCode {
                    Text("Re-enter your new passcode".localized())
                } else {
                    Text("Re-enter your new passcode".localized()).hidden()
                }
            }
        }
        
        var keypad: some View {
            KeypadView(viewModel: self.viewModel)
        }
        
        var biometricsButton: some View {
            Group {
                if Passcode.shared.getBiometrics() {
                    Button(action: {
                        self.viewModel.biometrics()
                    }, label: {
                        Text(Passcode.shared.biometrics.description)
                            .padding()
                    }).foregroundColor(Color(Passcode.shared.config.color))
                } else {
                    self.cancelButton.hidden()
                }
            }
        }
        
        var cancelButton: some View {
            Button(action: {
                self.viewModel.cancel()
            }, label: {
                Text("Cancel".localized())
            }).foregroundColor(Color(Passcode.shared.config.color))
                .padding()
        }
    }
}

struct AuthenticateView_Previews: PreviewProvider {
    static var previews: some View {
        Passcode.PasscodeView(viewModel: Passcode.ViewModel(host: ViewController(),
                                                            mode: .changeCode,
                                                            completion: { _ in }))
    }
}
