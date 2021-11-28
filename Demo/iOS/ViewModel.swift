//
//  ViewModel.swift
//  Demo (iOS)
//
//  Created by David Walter on 28.11.21.
//

import Foundation
import Combine
import SwiftUI
import Settings

class ViewModel: ObservableObject {
    @Published var colorScheme: ColorScheme?
    
    private var cancellables = [AnyCancellable]()
    
    init() {
        NotificationCenter.default
            .publisher(for: Settings.schemeDidChange)
            .sink { _ in
                switch Settings.colorScheme {
                case .light:
                    print("Color scheme changed to light")
                case .dark:
                    print("Color scheme changed to dark")
                default:
                    print("Color scheme changed to unspecified")
                }
                
                self.colorScheme = Settings.colorScheme
            }
            .store(in: &cancellables)
    }
}
