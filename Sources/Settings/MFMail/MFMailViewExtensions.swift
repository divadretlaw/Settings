//
//  MFMailViewExtensions.swift
//  Settings
//
//  Created by David Walter on 25.12.20.
//

#if !os(macOS)
import MessageUI
import SwiftUI

extension View {
    public func mailSheet(_ options: MFMailView.Options? = nil,
                          result: Binding<Result<MFMailComposeResult, Error>?>,
                          isPresented: Binding<Bool>,
                          onDismiss: (() -> Void)? = nil) -> some View {
        sheet(isPresented: isPresented,
              onDismiss: onDismiss) {
            MFMailView(options: options, isShowing: isPresented, result: result)
        }
    }
}
#endif
