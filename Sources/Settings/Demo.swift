//
//  Demo.swift
//  Settings
//
//  Created by David Walter on 27.03.21.
//

#if DEBUG
import SwiftUI

struct ContentView: View {
    enum Sheet: String, Identifiable {
        case settings
        case other
        
        var id: String { self.rawValue }
    }
    
    @State var sheet: Sheet?
    @State var showSettings = false
    
    var body: some View {
        TabView {
            NavigationView {
                Button(action: {
                    self.sheet = .settings
                    self.showSettings = true
                }, label: {
                    Text("Show Settings as a Sheet")
                })
            }
            .sheet(item: $sheet, content: { sheet in
                switch sheet {
                case .settings:
                    self.settingsSheet
                case .other:
                    Text("Some sheet")
                }
            })
            .tabItem {
                Image(systemName: "gearshape.2.fill")
                Text("Home")
            }
            
            self.settingsView
        }
    }
    
    var settingsView: some View {
        SettingsView {
            NavigationLink(destination: Settings.AdvancedAppearanceView()) {
                Text("Appearance")
            }

            Settings.ResetView()
            
            Section(footer: Settings.AboutSectionView()) {}
        }.tabItem {
            Image(systemName: "gear")
            Text("Settings")
        }
    }
    
    var settingsSheet: some View {
        SettingsView(showSettings: $showSettings) {
            NavigationLink(destination: Settings.AdvancedAppearanceView()) {
                Text("Appearance")
            }

            Section(footer: Settings.AboutSectionView()) {}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
