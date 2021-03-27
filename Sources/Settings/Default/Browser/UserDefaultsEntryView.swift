// Urheberrechtshinweis: Diese Software ist urheberrechtlich geschützt. Das Urheberrecht liegt bei
// Research Industrial Systems Engineering (RISE) Forschungs-, Entwicklungs- und Großprojektberatung GmbH,
// soweit nicht im Folgenden näher gekennzeichnet.

import SwiftUI

struct UserDefaultsEntryView: View {
    @ObservedObject var viewModel: UserDefaultsEntryViewModel
    @State var showConfirmationDialog: Bool = false
    @Environment(\.presentationMode) var presentationMode

    #if os(iOS)
    var body: some View {
        List {
            view(for: viewModel.entry)
            rawData(for: viewModel.entry)
        }
        .navigationBarTitle(viewModel.entry.key)
        .dismissable()
    }
    #else
    var body: some View {
        List {
            view(for: viewModel.entry)
            rawData(for: viewModel.entry)
        }
        .navigationTitle(viewModel.entry.key)
    }
    #endif

    func view(for entry: UserDefaultsViewModel.UserDefaultEntry) -> some View {
        let mirror: Mirror
        if let data = entry.value as? Data, let unarchived = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) {
            mirror = Mirror(reflecting: unarchived)
        } else {
            mirror = Mirror(reflecting: entry.value)
        }
        let views = mirror.children.map { child in
            HStack {
                child.label.map { Text($0) }
                child.label.map { _ in Spacer() }
                Text(String(reflecting: unwrap(child.value)))
                    .frame(alignment: Alignment.trailing)
                    .font(.system(.body, design: .monospaced))
            }
        }
        return ForEach(0 ..< views.count) { index in views[index] }
    }

    func rawData(for entry: UserDefaultsViewModel.UserDefaultEntry) -> AnyView? {
        guard let data = entry.value as? Data else {
            return nil
        }
        return AnyView(Section(header: Text("Raw".localized())) {
            HStack {
                Text(String(describing: format(data)))
                    .frame(alignment: Alignment.trailing)
                    .font(.system(.body, design: .monospaced))
            }
        })
    }
}

struct UserDefaultsEntryView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsEntryView(viewModel: UserDefaultsEntryViewModel(entry: UserDefaultsViewModel.UserDefaultEntry(key: "Key", value: "String")))
    }
}
