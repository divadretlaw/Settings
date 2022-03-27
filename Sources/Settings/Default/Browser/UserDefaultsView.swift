//
//  UserDefaultsView.swift
//  Settings
//
//  Created by David Walter on 05.02.21.
//

import SwiftUI

@available(iOS 14.0, macOS 11, *)
public struct UserDefaultsView: View {
    @StateObject var viewModel = UserDefaultsViewModel()

    public var body: some View {
        #if os(iOS)
        list.dismissable()
        #else
        list
        #endif
    }
    
    var list: some View {
        List {
            ForEach(viewModel.entries, id: \.id) { entry in
                self.row(for: entry)
                    .contextMenu {
                        Button {
                            self.viewModel.delete(entry: entry)
                        } label: {
                            Label("common.delete".localized(), systemImage: "trash")
                        }
                    }
            }
        }
        .listStyle(.plain)
        .navigationTitle("userdefaults.title".localized())
        .onAppear {
            self.viewModel.loadAllUserDefaults()
        }
    }

    @ViewBuilder
    func row(for entry: UserDefaultsViewModel.UserDefaultEntry) -> some View {
        if isSimpleType(entry.value) {
            HStack {
                Text(entry.key)
                Spacer()
                Text(String(reflecting: entry.value))
                    .frame(alignment: .trailing)
                    .font(.system(.body, design: .monospaced))
            }
        } else {
            NavigationLink {
                UserDefaultsEntryView(viewModel: UserDefaultsEntryViewModel(entry: entry))
            } label: {
                HStack {
                    Text(entry.key)
                    Spacer()
                    Text(String(describing: type(of: entry.value)))
                }
            }
        }
    }
    
    func isSimpleType<T>(_ object: T) -> Bool {
        switch object {
        case is Bool, is Date, is Double, is Float, is Int, is String: return true
        default: return false
        }
    }
    
    public init() {
    }
}

#if DEBUG
@available(iOS 14.0, macOS 11.0, *)
struct UserDefaultsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDefaultsView()
        }
    }
}
#endif
