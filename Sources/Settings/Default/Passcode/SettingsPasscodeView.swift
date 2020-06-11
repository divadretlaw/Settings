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
    public struct PasscodeView: View, HeaderView {
        public var header = (title: "Passcode", show: true)
        @State var isOn: Bool
        @State var showEdit = false
        
        public var body: some View {
            Section(header: self.headerView) {
                Button(action: {
                    if self.isOn {
                        Passcode.shared.askCode { self.showEdit = $0 }
                    } else {
                        Passcode.shared.changeCode {
                            self.isOn = $0
                            self.showEdit = $0
                        }
                    }
                }, label: {
                    ZStack {
                        NavigationLink(destination: PasscodeEditView { self.isOn = $0 }, isActive: $showEdit, label: { EmptyView() }).hidden()
                        HStack {
                            Text("Passcode".localized())
                            Spacer()
                            if isOn == true {
                                Text("On".localized())
                                    .foregroundColor(Color.secondary)
                            } else if isOn == false {
                                Text("Off".localized())
                                    .foregroundColor(Color.secondary)
                            } else {
                                EmptyView()
                            }
                        }
                    }
                })
            }
        }
        
        public init() {
            self._isOn = State(initialValue: Passcode.shared.hasCode())
        }
    }
}

struct SettingsPasscodeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                Settings.PasscodeView()
            }
        }
    }
}
#endif
