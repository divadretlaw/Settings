//
//  CodeView.swift
//  Passcode
//
//  Created by David Walter on 28.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

extension Passcode {
    struct CodeView: View {
        @ObservedObject var viewModel: Passcode.ViewModel
        
        var body: some View {
            VStack {
                HStack {
                    ForEach(0..<viewModel.length) { index in
                        CharacterView(isOn: index < self.viewModel.text.count)
                            .padding()
                    }
                }.id(viewModel.text)
            }
        }
    }
    
    fileprivate struct CharacterView: View {
        @State var isOn: Bool
        
        var body: some View {
            Image(systemName: isOn ? "circle.fill" : "circle")
        }
    }
}

#if DEBUG
struct CodeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            Passcode.CodeView(viewModel: Passcode.ViewModel(host: UIViewController(),
                                                            mode: .authentication,
                                                            completion: { _ in }))
            Spacer()
            Spacer()
        }
    }
}
#endif
