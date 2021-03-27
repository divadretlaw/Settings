//
//  SettingsSupportView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

#if os(iOS)
import SwiftUI
import MessageUI

extension Settings {
    public struct SupportView: View, HeaderView {
        public var header = (title: "Support", show: true)
        
        @State private var result: Result<MFMailComposeResult, Error>?
        @State private var showMFMailView = false
        
        public var body: some View {
            Section(header: self.headerView) {
                Button(action: {
                    self.showMFMailView = true
                }, label: {
                    Text("Email Developer".localized())
                }).disabled(!MFMailComposeViewController.canSendMail())
                .mailSheet(Settings.Configuration.shared.mailOptions,
                           result: self.$result,
                           isPresented: self.$showMFMailView)
            }
        }
        
        public init() {
            
        }
    }
}

struct SettingsSupportView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Settings.SupportView()
        }
    }
}
#endif
