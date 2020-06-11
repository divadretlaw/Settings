//
//  SettingsResetView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

extension Settings {
    public struct ResetView: View {
        var header: String?
        var buttonTitle: String
        var alertHeader: String
        var alertMessage: String
        var alertAction: String
        
        @ObservedObject var viewModel: ViewModel
        @State private var showResetAlert = false
        
        public var body: some View {
            Section(header: self.headerView) {
                Button(action: {
                    self.showResetAlert = true
                }, label: {
                    Text(self.buttonTitle).foregroundColor(.red)
                }).alert(isPresented: $showResetAlert) {
                    Alert(title: Text(self.alertHeader),
                          message: Text(self.alertMessage),
                          primaryButton: .destructive(Text(self.alertAction)) {
                            self.viewModel.resetAll()
                        },
                          secondaryButton: .cancel())
                }
            }
        }
        
        var headerView: some View {
            Group {
                if header == nil {
                    EmptyView()
                } else {
                    Text(header ?? "")
                }
            }
        }
        
        public init(header: String? = "Reset",
                    buttonTitle: String = "Reset all data",
                    alertHeader: String = "Reset all data?",
                    alertMessage: String = "All data on this device will be deleted, and all settings will be reset to default, you won't be able to undo this action",
                    alertAction: String = "Reset all data") {
            self.header = header
            self.buttonTitle = buttonTitle
            self.alertHeader = alertHeader
            self.alertMessage = alertMessage
            self.alertAction = alertAction
            self.viewModel = ViewModel()
        }
    }
}
extension Settings.ResetView {
    class ViewModel: ObservableObject {
        func resetAll() {
            guard let identifier = Bundle.main.bundleIdentifier else { return }
            UserDefaults.standard.removePersistentDomain(forName: identifier)
            
        }
    }
    
}

#if DEBUG
struct SettingsResetView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Settings.ResetView()
        }.listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
    }
}
#endif
