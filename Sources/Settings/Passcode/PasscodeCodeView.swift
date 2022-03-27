//
//  CodeView.swift
//  Passcode
//
//  Created by David Walter on 28.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

struct CodeView: View {
    @ObservedObject var viewModel: Passcode.ViewModel
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0 ..< viewModel.length, id: \.self) { index in
                    CharacterView(isOn: index < self.viewModel.text.count)
                        .padding()
                }
            }
            .id(viewModel.text)
        }
    }
}

struct CharacterView: View {
    @State var isOn: Bool
    
    var body: some View {
        Image(systemName: isOn ? "circle.fill" : "circle")
    }
}

struct CodeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            CodeView(viewModel: Passcode.ViewModel(host: ViewController(),
                                                   mode: .authentication,
                                                   completion: { _ in }))
            Spacer()
            Spacer()
        }
    }
}
