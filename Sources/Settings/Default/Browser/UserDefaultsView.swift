//
//  SwiftUIView.swift
//  
//
//  Created by David Walter on 05.02.21.
//

import SwiftUI

@available(iOS 14.0, macOS 11, *)
public struct UserDefaultsView: View {
    @StateObject var viewModel: UserDefaultsViewModel = UserDefaultsViewModel()

    #if os(iOS)
    public var body: some View {
        List {
            ForEach(viewModel.entries, id: \.id) { entry in
                self.row(for: entry)
                    .contextMenu(menuItems: {
                        Button(action: {
                            self.viewModel.delete(entry: entry)
                        }, label: {
                            Image(systemName: "trash")
                            Text("common.delete".localized())
                        })
                    })
            }
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("userdefaults.title".localized())
        .dismissable()
        .onAppear {
            self.viewModel.loadAllUserDefaults()
        }
    }
    #else
    public var body: some View {
        List {
            ForEach(viewModel.entries, id: \.id) { entry in
                self.row(for: entry)
                    .contextMenu(menuItems: {
                        Button(action: {
                            self.viewModel.delete(entry: entry)
                        }, label: {
                            Image(systemName: "trash")
                            Text("common.delete".localized())
                        })
                    })
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("userdefaults.title".localized())
        .onAppear {
            self.viewModel.loadAllUserDefaults()
        }
    }
    #endif

    @ViewBuilder
    func row(for entry: UserDefaultsViewModel.UserDefaultEntry) -> some View {
        if isSimpleType(entry.value) {
            HStack {
                Text(entry.key)
                Spacer()
                Text(String(reflecting: entry.value))
                    .frame(alignment: Alignment.trailing)
                    .font(.system(.body, design: .monospaced))
            }
        } else {
            NavigationLink(destination: UserDefaultsEntryView(viewModel: UserDefaultsEntryViewModel(entry: entry))) {
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
            case is Bool, is Int, is Float, is Double, is String, is Date: return true
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
