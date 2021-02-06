//
//  SwiftUIView.swift
//  
//
//  Created by David Walter on 06.02.21.
//

import SwiftUI

struct CheckmarkToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Button(action: {
                withAnimation {
                    if !configuration.isOn {
                        configuration.$isOn.wrappedValue.toggle()
                    }
                }
            }, label: {
                HStack {
                    configuration.label
                        .foregroundColor(Color(.label))
                    Spacer()
                    Image(systemName: "checkmark")
                        .opacity(configuration.isOn ? 1 : 0)
                        .accessibility(removeTraits: .isImage)
                        .accessibility(addTraits: .isButton)
                }
            })
        }
    }
}
