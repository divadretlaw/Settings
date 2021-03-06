//
//  HeaderView.swift
//  Settings
//
//  Created by David Walter on 27.03.21.
//

import SwiftUI

public protocol HeaderView {
    var header: (title: String, show: Bool) { get set }
    
    associatedtype Content: View
    var headerView: Content { get }
    
    func hideHeader(_ value: Bool) -> Self
}

extension HeaderView {
    public func hideHeader(_ value: Bool) -> Self {
        var view = self
        view.header.show = !value
        return view
    }
    
    @ViewBuilder
    public var headerView: some View {
        if header.show {
            Text(header.title.localized())
        } else {
            EmptyView()
        }
    }
}
