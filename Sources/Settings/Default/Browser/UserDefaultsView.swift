//
//  SwiftUIView.swift
//  
//
//  Created by David Walter on 05.02.21.
//

import SwiftUI

public struct UserDefaultsView: View {
    @ObservedObject var viewModel: UserDefaultsViewModel = UserDefaultsViewModel()

    public var body: some View {
        List {
            ForEach(viewModel.entries, id: \.id) { entry in
                self.row(for: entry)
                    .contextMenu(menuItems: {
                        Button(action: {
                            self.viewModel.delete(entry: entry)
                        }, label: {
                            Image(systemName: "trash")
                            Text("Delete".localized())
                        })
                    })
            }
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("UserDefaults Browser".localized())
        .navigationBarItems(trailing: NavBarButton(action: {
            Dismisser.shared?.dismiss()
        }, text: Text("Done".localized())))
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

struct UserDefaultsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDefaultsView()
        }
    }
}
