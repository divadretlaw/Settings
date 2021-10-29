//
//  DemoApp.swift
//  Shared
//
//  Created by David Walter on 14.04.21.
//

import SwiftUI

@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        Settings {
            PreferencesView()
                .padding()
        }
        #endif
    }
}
