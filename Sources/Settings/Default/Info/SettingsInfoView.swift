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
                Settings.InfoView(infos: infos, bundle: bundle)
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
        
        public enum Layout {
            case horizontal
            case vertical
        }
        
        var layout = Layout.horizontal
        
        public var body: some View {
            ForEach(infos, id: \.self) { info in
                if layout == .horizontal {
                    HStack {
                        Text(info.title.localized())
                            .foregroundColor(.primary)
                        Spacer()
                        Text(value(for: info))
                            .foregroundColor(.secondary)
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text(info.title.localized())
                            .foregroundColor(.primary)
                        Text(value(for: info))
                            .foregroundColor(.secondary)
                    }
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
        
        public func layout(_ layout: Layout) -> Self {
            var view = self
            view.layout = layout
            return view
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
            
            Settings.InfoView(infos: [.version,
                             .buildNumber,
                             .appName,
                             .sdkVersion])
            .layout(.vertical)
        }
    }
}
