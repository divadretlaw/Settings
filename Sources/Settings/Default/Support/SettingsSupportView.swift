//
//  SettingsSupportView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

#if os(iOS)
import MessageUI
import SwiftUI

extension Settings {
    public struct SupportSection: View, HeaderView {
        public var header = (title: "support.title", show: true)
        
        @State private var result: Result<MFMailComposeResult, Error>?
        @State private var showMFMailView = false
        
        public var body: some View {
            Section {
                SupportView()
            } header: {
                headerView
            }
        }
        
        public init() {
        }
    }
    
    public struct SupportView: View {
        @State private var result: Result<MFMailComposeResult, Error>?
        @State private var showMFMailView = false
        
        public var body: some View {
            Button {
                self.showMFMailView = true
            } label: {
                Text("support.email".localized())
            }
            .disabled(!MFMailComposeViewController.canSendMail())
            .mailSheet(Settings.Configuration.shared.mailOptions,
                       result: self.$result,
                       isPresented: self.$showMFMailView)
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
