//
//  MFMailButton.swift
//  Settings
//
//  Created by David Walter on 11.06.22.
//

#if !os(macOS)
import SwiftUI
import MessageUI

public struct MFMailButton<Content>: View where Content: View {
    @ViewBuilder var label: () -> Content
    
    @State private var result: Result<MFMailComposeResult, Error>?
    @State private var showMFMailView = false
    
    public var body: some View {
        Button(action: {
            
        }, label: label)
        .disabled(!MFMailComposeViewController.canSendMail())
        .mailSheet(Settings.Configuration.shared.mailOptions,
                   result: self.$result,
                   isPresented: self.$showMFMailView)
    }
    
    public init(@ViewBuilder label: @escaping () -> Content) {
        self.label = label
    }
}

struct MFMailButton_Previews: PreviewProvider {
    static var previews: some View {
        MFMailButton {
            Text("Test")
        }
    }
}
#endif
