//
//  PreferencesView.swift
//  Demo - macOS
//
//  Created by David Walter on 14.04.21.
//

import SwiftUI
import Settings

struct PreferencesView: View {
    var body: some View {
        SettingsView {
            Form {
                Settings.AppearanceView()
                
                Settings.ResetView()
            }
            .padding()
            .tabItem { Label("General", systemImage: "gearshape") }
            
            Settings.AdvancedAppearanceView()
                .frame(minWidth: 500, minHeight: 500)
                .tabItem { Label("Appearance", systemImage: "paintbrush") }
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
