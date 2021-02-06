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
                    if configuration.isOn {
                        Image(systemName: "checkmark.circle.fill")
                            .font(SwiftUI.Font.headline.weight(.bold))
                            .accessibility(removeTraits: .isImage)
                            .accessibility(addTraits: .isButton)
                    } else {
                        Image(systemName: "circle")
                            .font(SwiftUI.Font.headline.weight(.light))
                            .foregroundColor(Color(.systemGray2))
                            .accessibility(removeTraits: .isImage)
                            .accessibility(addTraits: .isButton)
                    }
                }
            })
        }
    }
}

#if DEBUG
struct CheckmarkToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Toggle(isOn: .constant(true), label: {
                Text("True")
            })
            .toggleStyle(CheckmarkToggleStyle())
            Toggle(isOn: .constant(false), label: {
                Text("False")
            })
            .toggleStyle(CheckmarkToggleStyle())
        }
    }
}
#endif
