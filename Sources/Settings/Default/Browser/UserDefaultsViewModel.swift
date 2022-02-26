//
//  UserDefaultsViewModel.swift
//  Settings
//
//  Created by David Walter on 05.02.21.
//

import Foundation

class UserDefaultsViewModel: ObservableObject, Identifiable {
    let id = UUID()
    @Published var entries: [UserDefaultEntry] = []
    
    func loadAllUserDefaults() {
        entries = Settings.userDefaults
            .dictionaryRepresentation()
            .map { UserDefaultEntry(key: $0, value: $1) }
            .sorted(by: <)
    }
    
    func delete(entry: UserDefaultEntry) {
        Settings.userDefaults.removeObject(forKey: entry.key)
    }
    
    func deleteRows(at offsets: IndexSet) {
        offsets.forEach { Settings.userDefaults.removeObject(forKey: entries.remove(at: $0).key) }
    }
    
    struct UserDefaultEntry: Identifiable, Comparable {
        let key: String
        let value: Any
        
        // MARK: - Identifiable
        
        var id: String { key }

        // MARK: - Comparable
        
        static func < (lhs: UserDefaultsViewModel.UserDefaultEntry, rhs: UserDefaultsViewModel.UserDefaultEntry) -> Bool {
            lhs.key < rhs.key
        }
        
        static func == (lhs: UserDefaultsViewModel.UserDefaultEntry, rhs: UserDefaultsViewModel.UserDefaultEntry) -> Bool {
            lhs.id == rhs.id
        }
    }
}
