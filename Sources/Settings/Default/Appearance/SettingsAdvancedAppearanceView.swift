//
//  SettingsAdvancedAppearanceView.swift
//  Settings
//
//  Created by David Walter on 06.02.21.
//

import SwiftUI

extension Settings {
    public struct AdvancedAppearanceView: View {
        @StateObject var viewModel = Appearance.ViewModel()
        
        #if os(iOS)
        public var body: some View {
            Form {
                self.content
            }
            .listStyle(.grouped)
            .navigationBarTitle("appearance.title".localized())
            .dismissable()
        }

        #elseif os(macOS)
        public var body: some View {
            List {
                self.content
            }
            .navigationTitle("appearance.title".localized())
        }
        #endif
        
        @ViewBuilder
        var content: some View {
            Section {
                Toggle(isOn: Binding(get: {
                    viewModel.matchSystemTheme
                }, set: {
                    viewModel.matchSystemTheme = $0
                }), label: {
                    VStack(alignment: .leading) {
                        Text("appearance.option.system".localized())
                            .font(.body)
                        Text("appearance.option.system.hint".localized())
                            .font(.caption)
                    }
                })
                .toggleStyle(.checkmark)
                
                Toggle(isOn: Binding(get: {
                    guard !viewModel.matchSystemTheme else { return false }
                    return viewModel.mode == .manual
                }, set: { value in
                    guard value else { return }
                    viewModel.matchSystemTheme = false
                    viewModel.mode = .manual
                }), label: {
                    VStack(alignment: .leading) {
                        Text("appearance.option.manually".localized())
                            .font(.body)
                        Text("appearance.option.manually.hint".localized())
                            .font(.caption)
                    }
                })
                    .toggleStyle(.checkmark)
                
                // Toggle(isOn: Binding(get: {
                //     guard !viewModel.matchSystemTheme else { return false }
                //     return viewModel.mode == .scheduled
                // }, set: { value in
                //     guard value else { return }
                //     viewModel.matchSystemTheme = false
                //     viewModel.mode = .scheduled
                // }), label: {
                //     VStack(alignment: .leading) {
                //         Text("appearance.option.scheduled")
                //             .font(.body)
                //         Text("appearance.option.scheduled.hint")
                //             .font(.caption)
                //     }
                // })
                // .toggleStyle(.checkmark)
                
                Toggle(isOn: Binding(get: {
                    guard !viewModel.matchSystemTheme else { return false }
                    return viewModel.mode == .automatically
                }, set: { value in
                    guard value else { return }
                    viewModel.matchSystemTheme = false
                    viewModel.mode = .automatically
                }), label: {
                    VStack(alignment: .leading) {
                        Text("appearance.option.automatically".localized())
                            .font(.body)
                        Text("appearance.option.automatically.hint".localized())
                            .font(.caption)
                    }
                })
                    .toggleStyle(.checkmark)
            }
            
            if !viewModel.matchSystemTheme {
                if viewModel.mode == .manual {
                    Section {
                        Toggle(isOn: Binding(get: {
                            !viewModel.useDarkMode
                        }, set: { value in
                            guard value else { return }
                            viewModel.useDarkMode = false
                        }), label: {
                            Text("appearance.option.manually.light".localized())
                        })
                            .toggleStyle(.checkmark)
                        
                        Toggle(isOn: Binding(get: {
                            viewModel.useDarkMode
                        }, set: { value in
                            guard value else { return }
                            viewModel.useDarkMode = true
                        }), label: {
                            Text("appearance.option.manually.dark".localized())
                        })
                            .toggleStyle(.checkmark)
                    } header: {
                        Text("appearance.option.manually.theme".localized())
                    }
                }
                
                if viewModel.mode == .scheduled {
                    Section {
                        DatePicker("appearance.option.scheduled.light".localized(),
                                   selection: .constant(Date()),
                                   displayedComponents: .hourAndMinute)
                        DatePicker("appearance.option.scheduled.dark".localized(),
                                   selection: .constant(Date()),
                                   displayedComponents: .hourAndMinute)
                    } header: {
                        Text("appearance.option.scheduled.dates".localized())
                    }
                }
                
                if viewModel.mode == .automatically {
                    Section {
                        Slider(value: $viewModel.threshold,
                               in: 0 ... 1,
                               minimumValueLabel: Image(systemName: "sun.min"),
                               maximumValueLabel: Image(systemName: "sun.max")) {
                            Text("appearance.option.automatically.slider".localized())
                        }
                        .accentColor(.gray)
                    } header: {
                        Text("appearance.option.automatically.slider".localized())
                    } footer: {
                        brightnessThreshold
                    }
                }
            }
        }
        
        var brightnessThreshold: some View {
            Text(String(format: "appearance.option.automatically.slider.hint".localized(), Int(viewModel.threshold * 100)))
        }
        
        public init() {
        }
    }
}

struct SettingsAdvancedAppearanceView_Previews: PreviewProvider {
    #if os(iOS)
    static var previews: some View {
        NavigationView {
            Settings.AdvancedAppearanceView()
        }
    }
    #else
    static var previews: some View {
        SettingsView {
            Settings.AdvancedAppearanceView()
                .tabItem {
                    Text("Appearance")
                }
        }
        .padding()
    }
    #endif
}
