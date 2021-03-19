//
//  SettingsAdvancedAppearanceView.swift
//
//
//  Created by David Walter on 06.02.21.
//

import SwiftUI

public extension Settings {
    struct AdvancedAppearanceView: View {
        @ObservedObject var viewModel: Appearance.ViewModel

        #if os(iOS)
        public var body: some View {
            Form {
                self.content
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Appearance".localized())
            .dismissable()
        }
        #elseif os(macOS)
        public var body: some View {
            List {
                self.content
            }
            .navigationTitle("Appearance".localized())
        }
        #endif

        @ViewBuilder
        var content: some View {
            Section {
                Toggle(isOn: self.$viewModel.matchSystemTheme) {
                    Text("Match System Theme".localized())
                }
            }.animation(.default)

            if !viewModel.matchSystemTheme {
                Section(header: Text("Switch")) {
                    Toggle(isOn: Binding(get: {
                        viewModel.mode == .manual
                    }, set: { value in
                        guard value else { return }
                        viewModel.mode = .manual
                    }), label: {
                        VStack(alignment: .leading) {
                            Text("Manually")
                                .font(.body)
                            Text("Only switch when you want")
                                .font(.caption)
                        }
                    }).toggleStyle(CheckmarkToggleStyle())

//                    Toggle(isOn: Binding(get: {
//                        viewModel.mode == .scheduled
//                    }, set: { value in
//                        guard value else { return }
//                        viewModel.mode = .scheduled
//                    }), label: {
//                        VStack(alignment: .leading) {
//                            Text("Scheduled")
//                                .font(.body)
//                            Text("At specific times")
//                                .font(.caption)
//                        }
//                    }).toggleStyle(CheckmarkToggleStyle())

                    Toggle(isOn: Binding(get: {
                        viewModel.mode == .automatically
                    }, set: { value in
                        guard value else { return }
                        viewModel.mode = .automatically
                    }), label: {
                        VStack(alignment: .leading) {
                            Text("Automatically")
                                .font(.body)
                            Text("Based on screen brightness")
                                .font(.caption)
                        }
                    }).toggleStyle(CheckmarkToggleStyle())
                }

                if viewModel.mode == .manual {
                    Section(header: Text("Theme")) {
                        Toggle(isOn: Binding(get: {
                            !viewModel.useDarkMode
                        }, set: { value in
                            guard value else { return }
                            viewModel.useDarkMode = false
                        }), label: {
                            Text("Light")
                        }).toggleStyle(CheckmarkToggleStyle())

                        Toggle(isOn: Binding(get: {
                            viewModel.useDarkMode
                        }, set: { value in
                            guard value else { return }
                            viewModel.useDarkMode = true
                        }), label: {
                            Text("Dark")
                        }).toggleStyle(CheckmarkToggleStyle())
                    }
                }

                if viewModel.mode == .scheduled {
                    Section(header: Text("Scheduled")) {
                        DatePicker("Light mode starts",
                                   selection: .constant(Date()),
                                   displayedComponents: .hourAndMinute)
                        DatePicker("Dark mode starts",
                                   selection: .constant(Date()),
                                   displayedComponents: .hourAndMinute)
                    }
                }

                if viewModel.mode == .automatically {
                    Section(header: Text("Brightness"), footer: brightnessThreshold) {
                        Slider(value: $viewModel.threshold,
                               in: 0 ... 1,
                               minimumValueLabel: Image(systemName: "sun.min"),
                               maximumValueLabel: Image(systemName: "sun.max")) {
                            Text("Brightness slider")
                        }.accentColor(.gray)
                    }
                }

            }

        }

        var brightnessThreshold: some View {
            Text("Will switch to dark mode when \(Int(viewModel.threshold * 100)) % brightness or less.")
        }

        public init() {
            viewModel = Appearance.ViewModel()
        }
    }
}

#if DEBUG
struct SettingsAdvancedAppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NavigationLink(
                destination: Settings.AdvancedAppearanceView(),
                isActive: .constant(true),
                label: {
                    Text("Appearance")
                }
            )

        }
    }
}
#endif
