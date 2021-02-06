//
//  SwiftUIView.swift
//  
//
//  Created by David Walter on 06.02.21.
//

#if os(iOS)
import SwiftUI

extension Settings {
    public struct AboutSectionView: View {
        @ObservedObject var viewModel: InfoPlistViewModel
        var additional: [String]
        
        public var body: some View {
            HStack(alignment: .center, spacing: 10) {
                Spacer()
                
                Bundle.main.icon.map {
                    Image(uiImage: $0)
                        .resizable()
                        .frame(width: 60, height: 60, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .center) {
                        Text(viewModel.value(for: .appName))
                            .font(.headline)
                        Text(viewModel.value(for: .version))
                            .font(.headline)
                    }
                    ForEach(additional, id: \.self) { text in
                        Text(text)
                            .font(.subheadline)
                    }
                }
                Spacer()
            }
        }
        
        public init(additional: [String] = []) {
            self.viewModel = InfoPlistViewModel(bundle: Bundle.main)
            self.additional = additional
        }
    }
}

#if DEBUG
struct AboutSectionView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Section(footer: Settings.AboutSectionView()) {
                Text("Test")
                Settings.AboutSectionView(additional: ["by David Walter"])
            }
        }.listStyle(GroupedListStyle())
    }
}
#endif

#endif
