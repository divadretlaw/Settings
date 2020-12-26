//
//  KeypadView.swift
//  Passcode
//
//  Created by David Walter on 28.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

struct KeypadView: View {
    @ObservedObject var viewModel: Passcode.ViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack(spacing: 20) {
                NumberButton(value: .text("1"), viewModel: self.viewModel)
                NumberButton(value: .text("2"), viewModel: self.viewModel)
                NumberButton(value: .text("3"), viewModel: self.viewModel)
            }
            HStack(spacing: 20) {
                NumberButton(value: .text("4"), viewModel: self.viewModel)
                NumberButton(value: .text("5"), viewModel: self.viewModel)
                NumberButton(value: .text("6"), viewModel: self.viewModel)
            }
            HStack(spacing: 20) {
                NumberButton(value: .text("7"), viewModel: self.viewModel)
                NumberButton(value: .text("8"), viewModel: self.viewModel)
                NumberButton(value: .text("9"), viewModel: self.viewModel)
            }
            HStack(spacing: 20) {
                NumberButton(value: .blank, viewModel: self.viewModel).hidden()
                NumberButton(value: .text("0"), viewModel: self.viewModel)
                NumberButton(value: .delete, viewModel: self.viewModel)
            }
        }.padding()
    }
}

private struct NumberButton: View {
    let value: Passcode.Value
    @ObservedObject var viewModel: Passcode.ViewModel
    
    var body: some View {
        Button(action: {
            self.viewModel.add(self.value)
        }, label: {
            ZStack {
                BlurView(style: Passcode.shared.config.buttonBlur)
                value.display
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }.clipShape(Circle())
            .frame(maxWidth: 100, maxHeight: 100)
        })
    }
}

extension Passcode.Value {
    var display: some View {
        switch self {
        case .text(let value):
            return AnyView(
                Text(value)
                    .font(.title)
                    .foregroundColor(Color(.label))
            )
        case .delete:
            return AnyView(
                Image(systemName: "delete.left")
                    .imageScale(.large)
                    .foregroundColor(Color(.label))
            )
        default:
            return AnyView(
                EmptyView()
            )
        }
    }
}

#if DEBUG
struct KeypadView_Previews: PreviewProvider {
    static var previews: some View {
        KeypadView(viewModel: Passcode.ViewModel(host: UIViewController(),
                                                 mode: .authentication,
                                                 completion: { _ in }))
    }
}
#endif
