//
//  SettingsSupportView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI
#if !os(macOS)
import MessageUI
#endif

extension Settings {
    public struct SupportView: View {
        private var header: String?
        private var buttonTitle: String
        
        @State private var result: Result<MFMailComposeResult, Error>? = nil
        @State private var showMFMailView = false
        
        public var body: some View {
            Group {
                #if !os(macOS)
                Section(header: self.headerView) {
                    Button(action: {
                        self.showMFMailView = true
                    }, label: {
                        Text(self.buttonTitle)
                    }).disabled(!MFMailComposeViewController.canSendMail())
                        .mailSheet(Settings.Configuration.shared.mailOptions,
                                   result: self.$result,
                                   isPresented: self.$showMFMailView)
                }
                #else
                EmptyView()
                #endif
            }
        }
        
        var headerView: some View {
            Group {
                if header == nil {
                    EmptyView()
                } else {
                    Text(header ?? "")
                }
            }
        }
        
        public init(header: String? = "Support",
                    buttonTitle: String = "Email developer") {
            self.header = header
            self.buttonTitle = buttonTitle
        }
    }
}
#if DEBUG
struct SettingsSupportView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Settings.SupportView()
        }.listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
    }
}
#endif
