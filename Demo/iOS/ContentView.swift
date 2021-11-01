//
//  ContentView.swift
//  Demo - iOS
//
//  Created by David Walter on 19.03.21.
//

import SwiftUI
import Settings

struct ContentView: View {
    @State var showSettings = false
    
    var body: some View {
        TabView {
            NavigationView {
                Button(action: {
                    self.showSettings = true
                }, label: {
                    Text("Show Settings as a Sheet")
                })
            }
            .sheet(isPresented: $showSettings) {
                self.settingsSheet
            }
            .tabItem {
                Label("Home", systemImage: "gearshape.2.fill")
            }
            
            self.settingsView
        }
    }
    
    var settingsView: some View {
        SettingsView {
            Settings.AppearanceView()
            
            NavigationLink(destination: Settings.AdvancedAppearanceView()) {
                Text("Advanced Appearance")
            }

            Settings.ResetView()
            
            Section(footer: Settings.AboutSectionView()) {}
        }.tabItem {
            Label("Settings", systemImage: "gear")
        }
    }
    
    var settingsSheet: some View {
        SettingsView(showSettings: $showSettings) {
            Settings.AppearanceView()
            
            NavigationLink(destination: Settings.AdvancedAppearanceView()) {
                Text("Advanced Appearance")
            }
            
            Settings.ResetView()
                .hideHeader(true)

            Section(footer: Settings.AboutSectionView()) {}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
