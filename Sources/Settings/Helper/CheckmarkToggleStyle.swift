//
//  CheckmarkToggleStyle.swift
//  Settings
//
//  Created by David Walter on 06.02.21.
//

import SwiftUI

struct CheckmarkToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Button {
                withAnimation {
                    if !configuration.isOn {
                        configuration.$isOn.wrappedValue.toggle()
                    }
                }
            } label: {
                HStack {
                    configuration.label
                        .foregroundColor(.primary)
                    Spacer()
                    if configuration.isOn {
                        Image(systemName: "checkmark.circle.fill")
                            .font(SwiftUI.Font.headline.weight(.bold))
                            .foregroundColor(onColor)
                            .accessibility(removeTraits: .isImage)
                            .accessibility(addTraits: .isButton)
                    } else {
                        Image(systemName: "circle")
                            .font(SwiftUI.Font.headline.weight(.light))
                            .foregroundColor(offColor)
                            .accessibility(removeTraits: .isImage)
                            .accessibility(addTraits: .isButton)
                    }
                }
            }
            .buttonStyle(.plain)
        }
    }
    
    var onColor: Color {
        return .accentColor
    }
    
    var offColor: Color {
        #if os(iOS)
        return Color(.systemGray2)
        #else
        return Color(.systemGray)
        #endif
    }
}

extension ToggleStyle where Self == CheckmarkToggleStyle {
    static var checkmark: CheckmarkToggleStyle {
        CheckmarkToggleStyle()
    }
}

struct CheckmarkToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Toggle(isOn: .constant(true)) {
                Text("True")
            }
            .toggleStyle(.checkmark)
        
            Toggle(isOn: .constant(false)) {
                Text("False")
            }
            .toggleStyle(.checkmark)
        }
    }
}
