//
//  SwiftUIView.swift
//  
//
//  Created by David Walter on 26.12.20.
//

import SwiftUI

extension Settings {
    public struct InfoView: View, HeaderView {
        public var header = (title: "Information", show: true)
        @ObservedObject var viewModel: InfoPlistViewModel
        
        var infos: [InfoPlistKey]
        
        public var body: some View {
            Section(header: self.headerView) {
                ForEach(infos, id: \.self) { info in
                    HStack {
                        Text(info.title.localized())
                        Spacer()
                        Text(viewModel.value(for: info))
                    }
                }
            }
        }
        
        public init(infos: [InfoPlistKey],
                    bundle: Bundle = Bundle.main) {
            self.infos = infos
            self.viewModel = InfoPlistViewModel(bundle: bundle)
        }
    }
}

private extension InfoPlistKey {
    var title: String {
        switch self {
        case .version:
            return "Version"
        case .buildNumber:
            return "Build Number"
        case .appName:
            return "App Name"
        case .sdkVersion:
            return "SDK"
        case .custom(let title):
            return title
        }
    }
}

struct SettingsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Settings.InfoView(infos: [.version,
                                      .buildNumber,
                                      .appName,
                                      .sdkVersion])
        }
    }
}
