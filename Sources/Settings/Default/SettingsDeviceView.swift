//
//  SettingsDeviceView.swift
//  Settings
//
//  Created by David Walter on 28.12.20.
//

import SwiftUI
// import UIKit

extension Settings {
    struct DeviceView: View {
        // let device = UIDevice.current
        var infos: [Any]
        
        var body: some View {
            Text("")
        }
    }
}

struct SettingsDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Settings.DeviceView(infos: [])
        }
    }
}
