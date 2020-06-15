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
        private var showHeader: Bool
        
        @State private var result: Result<MFMailComposeResult, Error>? = nil
        @State private var showMFMailView = false
        
        public var body: some View {
            Group {
                #if !os(macOS)
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
                #else
                EmptyView()
                #endif
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
        }.listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
    }
}
#endif
