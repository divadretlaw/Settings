// Urheberrechtshinweis: Diese Software ist urheberrechtlich geschützt. Das Urheberrecht liegt bei
// Research Industrial Systems Engineering (RISE) Forschungs-, Entwicklungs- und Großprojektberatung GmbH,
// soweit nicht im Folgenden näher gekennzeichnet.

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
