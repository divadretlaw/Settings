//
//  SettingsPasscodeView.swift
//  Settings
//
//  Created by David Walter on 28.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

#if os(iOS)
import SwiftUI

extension Settings {
    public struct PasscodeSection: View, HeaderView {
        public var header = (title: "passcode.title", show: true)
        
        public var body: some View {
            Section {
                PasscodeView()
            } header: {
                headerView
            }
        }
        
        public init() {
        }
    }
    
    public struct PasscodeView: View {
        @State private var isOn: Bool = Passcode.shared.hasCode()
        @State private var showEdit = false
        
        public var body: some View {
            Button {
                if self.isOn {
                    Passcode.shared.askCode { self.showEdit = $0 }
                } else {
                    Passcode.shared.changeCode {
                        self.isOn = $0
                        self.showEdit = $0
                    }
                }
            } label: {
                ZStack {
                    NavigationLink(destination: PasscodeEditView { self.isOn = $0 },
                                   isActive: $showEdit) {
                        EmptyView()
                    }
                    .hidden()
                    
                    HStack {
                        Text("passcode.title".localized())
                        
                        Spacer()
                        
                        if isOn == true {
                            Text("passcode.on".localized())
                                .foregroundColor(Color.secondary)
                        } else if isOn == false {
                            Text("passcode.off".localized())
                                .foregroundColor(Color.secondary)
                        } else {
                            EmptyView()
                        }
                    }
                }
            }
        }
        
        public init() {
        }
    }
}

struct SettingsPasscodeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Settings.PasscodeSection()
            }
        }
    }
}
#endif
