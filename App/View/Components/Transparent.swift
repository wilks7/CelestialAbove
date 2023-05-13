//
//  Transparent.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI

extension View {
    func transparent(cornderRadius: CGFloat = 16) -> some View {
        self
            .background(.ultraThinMaterial)
            .cornerRadius(cornderRadius)
    }
}
