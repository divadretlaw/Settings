//
//  InfoSection.swift
//  Settings
//
//  Created by David Walter on 26.12.20.
//

import SwiftUI

extension Settings {
    public struct InfoSection: View, HeaderView {
        public var header = (title: "info.title", show: true)
        var infos: [InfoPlistKey]
        var bundle: Bundle
        
        public var body: some View {
            Section {
                InfoView(infos: infos, bundle: bundle)
            } header: {
                headerView
            }
        }
        
        public init(infos: [InfoPlistKey], bundle: Bundle = Bundle.main) {
            self.infos = infos
            self.bundle = bundle
        }
    }
    
    public struct InfoView: View {
        var infos: [InfoPlistKey]
        var bundle: Bundle

        public var body: some View {
            ForEach(infos, id: \.self) { info in
                HStack {
                    Text(info.title.localized())
                    Spacer()
                    Text(value(for: info))
                }
            }
        }
        
        public init(infos: [InfoPlistKey], bundle: Bundle = Bundle.main) {
            self.infos = infos
            self.bundle = bundle
        }
        
        func value(for key: InfoPlistKey) -> String {
            guard let infoDict = bundle.infoDictionary,
                  let value = infoDict[key.rawValue] as? String else {
                return ""
            }
            return value
        }
    }
}

extension InfoPlistKey {
    fileprivate var title: String {
        switch self {
        case .version:
            return "info.version".localized()
        case .buildNumber:
            return "info.buildnumber".localized()
        case .appName:
            return "info.appname".localized()
        case .sdkVersion:
            return "info.sdk".localized()
        case let .custom(title):
            return title
        }
    }
}

struct SettingsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Settings.InfoSection(infos: [.version,
                                         .buildNumber,
                                         .appName,
                                         .sdkVersion])
        }
    }
}
