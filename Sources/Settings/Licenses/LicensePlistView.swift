//
//  LicensePlistView.swift
//  Settings
//
//  Created by David Walter on 13.02.22.
//

import SwiftUI

extension Settings {
    public struct LicensePlistView: View {
        var data: LicensePlist
        
        public var body: some View {
            List {
                ForEach(data.entries, id: \.self) { entry in
                    NavigationLink {
                        List {
                            Section {
                                
                            } footer: {
                                Text(entry.license)
                            }
                        }
                        .navigationBarTitle(entry.title)
                    } label: {
                        Text(entry.title)
                    }
                }
            }
            .navigationBarTitle("licenses.title".localized())
        }
        
        public init(data: LicensePlist) {
            self.data = data
        }
    }
}
#if DEBUG
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Settings.LicensePlistView(data: LicensePlist())
        }
    }
}
#endif
