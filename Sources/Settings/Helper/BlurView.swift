//
//  BlurView.swift
//  Settings
//
//  Created by David Walter on 14.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI
#if os(iOS)
import UIKit

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {
        
    }
}
#elseif os(macOS)
import AppKit

struct BlurView: NSViewRepresentable {
    let mode: NSVisualEffectView.BlendingMode
    
    func makeNSView(context: NSViewRepresentableContext<BlurView>) -> NSView {
        let view = NSView(frame: .zero)
        //        view.backgroundColor = .clear
        let blurView = NSVisualEffectView()
        blurView.material = .contentBackground
        blurView.blendingMode = mode
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }
    
    func updateNSView(_ nsView: NSView,
                      context: NSViewRepresentableContext<BlurView>) {
        
    }
}
#endif
