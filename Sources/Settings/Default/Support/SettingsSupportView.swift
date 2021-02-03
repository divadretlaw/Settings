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
    public struct SupportView: View {
        private var showHeader: Bool
        
        @State private var result: Result<MFMailComposeResult, Error>?
        @State private var showMFMailView = false
        
        public var body: some View {
            Group {
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
        }
        
        var headerView: some View {
            Group {
                if showHeader {
                    Text("Support".localized())
                } else {
                    EmptyView()
                }
            }
        }
        
        public init(showHeader: Bool = true) {
            self.showHeader = showHeader
        }
    }
}

#if DEBUG
struct SettingsSupportView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Settings.SupportView()
        }
    }
}
#endif
#endif
