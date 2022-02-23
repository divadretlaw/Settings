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
    @State var someCustomSetting = false
    
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
                SettingsView(showSettings: $showSettings) {
                    settingsContent
                }
            }
            .tabItem {
                Label("Home", systemImage: "gearshape.2.fill")
            }
            
            SettingsView {
                settingsContent
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
    
    @ViewBuilder
    var settingsContent: some View {
        Section {
            Toggle(isOn: $someCustomSetting) {
                Text("Some custom setting")
            }
            
            NavigationLink {
                customSettings
            } label: {
                Text("Custom Setting Link")
            }
        }
        
        NavigationLink {
            Settings.AlternativeIconView(icons: AlternativeAppIcon.allCases)
        } label: {
            Text("Alternative App Icons")
        }
        
        Settings.PasscodeSection()

        Settings.AppearanceSection()
        
        Section {
            NavigationLink {
                Settings.AdvancedAppearanceView()
            } label: {
                Text("Advanced Appearance")
            }
        }
        
        Section {
            Settings.InfoView(infos: [.appName, .version, .buildNumber, .sdkVersion])
            
            NavigationLink {
                UserDefaultsView()
            } label: {
                Text("UserDefaults Browser")
            }
            
            Settings.ResetView()
        } footer: {
            Settings.AboutSectionView()
                .padding()
        }
    }
    
    var customSettings: some View {
        Form {
            Toggle(isOn: $someCustomSetting) {
                Text("Some custom setting")
            }
        }
        .navigationTitle("Custom Setting Link")
        .settingsDismissable()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
