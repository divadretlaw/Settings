//
//  MFMailView.Options.swift
//  
//
//  Created by David Walter on 25.12.20.
//

#if !os(macOS)
import Foundation

extension MFMailView {
    public struct Options {
        public init(toRecipients: [String]?,
                    ccRecipients: [String]?,
                    bccRecipients: [String]?,
                    subject: String?,
                    messageBody: String?) {
            self.toRecipients = toRecipients
            self.ccRecipients = ccRecipients
            self.bccRecipients = bccRecipients
            self.subject = subject
            self.messageBody = messageBody
        }
        
        let toRecipients: [String]?
        let ccRecipients: [String]?
        let bccRecipients: [String]?
        let subject: String?
        let messageBody: String?
        let isHTML: Bool = false
    }
}
#endif
