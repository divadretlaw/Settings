//
//  MFMailViewExtensions.swift
//  
//
//  Created by David Walter on 25.12.20.
//

#if !os(macOS)
import SwiftUI
import MessageUI

public extension View {
    func mailSheet(_ options: MFMailView.Options? = nil,
                   result: Binding<Result<MFMailComposeResult, Error>?>,
                   isPresented: Binding<Bool>,
                   onDismiss: (() -> Void)? = nil) -> some View {
        self.sheet(isPresented: isPresented,
                   onDismiss: onDismiss) {
            MFMailView(options: options, isShowing: isPresented, result: result)
        }
    }
}
#endif
