//
//  SettingsResetView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

public struct SettingsResetView: View {
    var header: String? = "Reset"
    @ObservedObject var viewModel = ViewModel()
    @State private var showResetAlert = false
    
    public var body: some View {
        Section(header: self.headerView) {
            Button(action: {
                self.showResetAlert = true
            }, label: {
                Text("Reset all data").foregroundColor(.red)
            }).alert(isPresented: $showResetAlert) {
                Alert(title: Text("Reset all data?"), message: Text("All data on this device will be deleted, and all settings will be reset to default, you won't be able to undo this action"), primaryButton: .destructive(Text("Reset all data")) {
                    self.viewModel.resetAll()
                    }, secondaryButton: .cancel())
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
}

extension SettingsResetView {
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
             SettingsResetView()
        }.listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
    }
}
#endif
