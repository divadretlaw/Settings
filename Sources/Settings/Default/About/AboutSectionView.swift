//
//  AboutSectionView.swift
//  Settings
//
//  Created by David Walter on 06.02.21.
//

#if os(iOS)
import SwiftUI

extension Settings {
    public struct AboutSectionView: View {
        var additional: [String]
        
        var titleColor = Color.primary
        var additionalColor = Color.primary
        
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
                    HStack(alignment: .center, spacing: 4) {
                        Text(value(for: .appName))
                            .font(.headline)
                        Text(value(for: .version))
                            .font(.headline)
                    }
                    .foregroundColor(titleColor)
                    
                    ForEach(additional, id: \.self) { text in
                        Text(text)
                            .font(.subheadline)
                            .foregroundColor(additionalColor)
                    }
                }
                
                Spacer()
            }
        }
        
        public init(additional: [String] = []) {
            self.additional = additional
        }
        
        func value(for key: InfoPlistKey) -> String {
            guard let infoDict = Bundle.main.infoDictionary, let value = infoDict[key.rawValue] as? String else {
                return ""
            }
            
            return value
        }
        
        public func titleColor(_ color: Color) -> Self {
            var view = self
            view.titleColor = color
            return view
        }
        
        public func additionalColor(_ color: Color) -> Self {
            var view = self
            view.additionalColor = color
            return view
        }
    }
}

struct AboutSectionView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Section {
                Text("Test")
                Settings.AboutSectionView(additional: ["by David Walter", "some longer text for testing"])
            } footer: {
                Settings.AboutSectionView()
            }
        }
        .listStyle(GroupedListStyle())
    }
}

#endif
