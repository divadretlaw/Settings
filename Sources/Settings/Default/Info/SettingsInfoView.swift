//
//  SwiftUIView.swift
//  
//
//  Created by David Walter on 26.12.20.
//

import SwiftUI

extension Settings {
    public struct InfoView: View {
        @ObservedObject var viewModel: InfoPlistViewModel
        
        var infos: [InfoPlistKey]
        var showHeader: Bool
        
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
        
        var headerView: some View {
            Group {
                if showHeader {
                    Text("Information".localized())
                } else {
                    EmptyView()
                }
            }
        }
        
        public init(infos: [InfoPlistKey],
                    showHeader: Bool = true,
                    bundle: Bundle = Bundle.main) {
            self.infos = infos
            self.viewModel = InfoPlistViewModel(bundle: bundle)
            self.showHeader = showHeader
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

#if DEBUG
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
#endif
