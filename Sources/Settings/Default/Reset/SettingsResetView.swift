//
//  SettingsResetView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

extension Settings {
    public struct ResetSection: View, HeaderView {
        public var header = (title: "reset.title", show: true)
        var reset: (() -> Void)?
        
        public var body: some View {
            Section(header: self.headerView) {
                ResetView(reset: reset)
            }
        }
        
        public init(reset: (() -> Void)? = nil) {
            self.reset = reset
        }
    }
    
    public struct ResetView: View {
        var reset: (() -> Void)?
        
        @StateObject private var viewModel = ViewModel()
        @State private var showResetAlert = false
        
        public var body: some View {
            Button {
                self.showResetAlert = true
            } label: {
                Text("reset.button".localized())
                    .foregroundColor(.red)
            }
            .alert(isPresented: $showResetAlert) {
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
        
        public init(reset: (() -> Void)? = nil) {
            self.reset = reset
        }
    }
}

struct SettingsResetView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Settings.ResetSection()
        }
    }
}
