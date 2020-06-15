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
        var showHeader: Bool
        
        @ObservedObject var viewModel: ViewModel
        @State private var showResetAlert = false
        
        public var body: some View {
            Section(header: self.headerView) {
                Button(action: {
                    self.showResetAlert = true
                }, label: {
                    Text("Reset all data".localized()).foregroundColor(.red)
                }).alert(isPresented: $showResetAlert) {
                    Alert(title: Text("Reset all data?".localized()),
                          message: Text("All data on this device will be deleted, and all settings will be reset to default, you won't be able to undo this action".localized()),
                          primaryButton: .destructive(Text("Reset all data".localized())) {
                            self.viewModel.resetAll()
                        },
                          secondaryButton: .cancel())
                }
            }
        }
        
        var headerView: some View {
            Group {
                if showHeader {
                    Text("Reset".localized())
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
