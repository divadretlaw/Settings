//
//  MFMailView.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

#if !os(macOS)
import SwiftUI
import MessageUI

public struct MFMailView: UIViewControllerRepresentable {
    
    public struct Options {
        let toRecipients: [String]?
        let ccRecipients: [String]?
        let bccRecipients: [String]?
        let subject: String?
        let messageBody: String?
        let isHTML: Bool = false
    }
    
    var options: Options?
    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?

    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(isShowing: Binding<Bool>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            self._isShowing = isShowing
            self._result = result
        }

        public func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                self.isShowing = false
            }
            
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            
            self.result = .success(result)
        }
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing, result: $result)
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<MFMailView>) -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = context.coordinator
        if let options = self.options {
            mail.setToRecipients(options.toRecipients)
            mail.setCcRecipients(options.ccRecipients)
            mail.setBccRecipients(options.bccRecipients)
            
            if let subject = options.subject {
                mail.setSubject(subject)
            }
            
            if let messageBody = options.messageBody {
                mail.setMessageBody(messageBody, isHTML: options.isHTML)
            }
        }
        return mail
    }

    public func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MFMailView>) {
    }
}

public extension View {
    func mailSheet(_ options: MFMailView.Options? = nil, result: Binding<Result<MFMailComposeResult, Error>?>, isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil) -> some View {
        self.sheet(isPresented: isPresented, onDismiss: onDismiss) {
            MFMailView(options: options, isShowing: isPresented, result: result)
        }
    }
}

#if DEBUG
struct MFMailView_Previews: PreviewProvider {
    static var previews: some View {
        MFMailView(options: nil, isShowing: .constant(true), result: .constant(nil))
    }
}
#endif

#endif
