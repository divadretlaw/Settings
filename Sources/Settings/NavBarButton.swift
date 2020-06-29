//
//  NavBarButton.swift
//  Settings
//
//  Created by David Walter on 11.06.20.
//  Copyright © 2020 David Walter. All rights reserved.
//

import SwiftUI

struct NavBarButton: View {
    var action: () -> Void
    
    var image: Image?
    var text: Text?
    
    var body: some View {
        Button(action: action, label: {
            if image != nil {
                self.image?
                    .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize,
                                  weight: .semibold,
                                  design: .default))
                    .padding(.vertical)
                    .padding(.horizontal, 10)
                    .imageScale(.large)
            } else {
                self.text?
                    .font(.system(size: UIFont.preferredFont(forTextStyle: .body).pointSize,
                                  weight: .semibold,
                                  design: .default))
                    .padding(.vertical)
            }
        })
    }
    
    init(action: @escaping () -> Void, text: Text) {
        self.action = action
        self.text = text
    }
    
    init(action: @escaping () -> Void, image: Image) {
        self.action = action
        self.image = image
    }
}

#if DEBUG
struct NavBarButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavBarButton(action: {}, text: Text("Done")).previewLayout(PreviewLayout.fixed(width: 150, height: 50))
            NavBarButton(action: {}, image: Image(systemName:  "heart.fill")).previewLayout(PreviewLayout.fixed(width: 150, height: 50))
        }
    }
}
#endif
