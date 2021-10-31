//
//  SettingsResetView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

extension Settings {
    public struct ResetView: View, HeaderView {
        public var header = (title: "reset.title".localized(), show: true)
        var reset: (() -> Void)?
        
        @ObservedObject var viewModel: ViewModel
        @State private var showResetAlert = false
        
        public var body: some View {
            Section(header: self.headerView) {
                Button(action: {
                    self.showResetAlert = true
                }, label: {
                    Text("reset.button".localized())
                        .foregroundColor(.red)
                }).alert(isPresented: $showResetAlert) {
                    Alert(title: Text("reset.alert.title".localized()),
                          message: Text("reset.alert.message".localized()),
                          primaryButton: .destructive(Text("reset.alert.destructive".localized())) {
                            self.viewModel.resetAll()
                            self.reset?()
                            Dismisser.shared?.dismiss()
                          },
                          secondaryButton: .cancel())
                }
            }
        }
        
        public init(reset: (() -> Void)? = nil) {
            self.reset = reset
            self.viewModel = ViewModel()
        }
    }
}

struct SettingsResetView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Settings.ResetView()
        }
    }
}
