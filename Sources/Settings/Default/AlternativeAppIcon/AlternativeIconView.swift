//
//  AlternativeIconView.swift
//  Settings
//
//  Created by David Walter on 05.11.21.
//

#if os(iOS) && !targetEnvironment(macCatalyst)
import SwiftUI
import UIKit

public protocol AlternateIcon: Identifiable, CaseIterable, Equatable {
    static var `default`: Self { get }
    
    var alternateIconName: String? { get }
    var preview: Image { get }
    
    var title: String { get }
    var subtitle: String? { get }
}

extension Settings {
    public struct AlternativeIconView<Icon: AlternateIcon>: View {
        var icons: [Icon]
        
        @State private var checkmark = UUID()
        
        public var body: some View {
            List {
                ForEach(icons) { item in
                    Button {
                        UIApplication.shared.setAlternateIconName(item.alternateIconName) { error in
                            guard error == nil else {
                                return
                            }
                            
                            checkmark = UUID()
                        }
                    } label: {
                        HStack {
                            item.preview
                                .frame(width: 60, height: 60, alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                item.subtitle.map {
                                    Text($0)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            Spacer()
                            
                            Image(systemName: "checkmark")
                                .font(.body.weight(.bold))
                                .opacity(UIApplication.shared.alternateIconName == item.alternateIconName ? 1 : 0)
                                .id(checkmark)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .listStyle(.grouped)
            .navigationBarTitle("appicon.title".localized())
            .settingsDismissable()
        }
        
        public init(icons: [Icon]) {
            self.icons = icons
        }
    }
}

#if DEBUG
enum PreviewAlternateIcon: String, AlternateIcon {
    case `default`
    case dark
    case long
    
    var id: String { rawValue }
    
    var alternateIconName: String? {
        switch self {
        case .dark:
            return "Dark"
        case .long:
            return "Long"
        default:
            return nil
        }
    }
    
    var preview: Image {
        switch self {
        case .dark:
            return Image(systemName: "app")
        case .long:
            return Image(systemName: "app.fill")
        default:
            return Image(systemName: "app")
        }
    }
    
    var title: String {
        switch self {
        case .dark:
            return "Dark"
        case .long:
            return "A very very long icon name, that is probably much too long"
        default:
            return "Default"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .dark:
            return "A darker variant of the default app icon"
        case .long:
            return "A long subtitle that explains nothing\nalso has a line break\nor two"
        default:
            return "The default app icon"
        }
    }
}

struct SettingsAlternativeIconView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Settings.AlternativeIconView(icons: PreviewAlternateIcon.allCases)
        }
    }
}
#endif
#endif
