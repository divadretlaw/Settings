//
//  UserDefaultsEntryViewModel.swift
//  Settings
//
//  Created by David Walter on 05.02.21.
//

import Foundation

class UserDefaultsEntryViewModel: ObservableObject, Identifiable {
    let id = UUID()
    @Published var entry: UserDefaultsViewModel.UserDefaultEntry
    
    init(entry: UserDefaultsViewModel.UserDefaultEntry) {
        self.entry = entry
    }
    
    func deleteEntry() {
        UserDefaults.standard.removeObject(forKey: entry.key)
    }
}
