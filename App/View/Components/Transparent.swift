//
//  Transparent.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI

extension View {
    func transparent(cornderRadius: CGFloat? = 16) -> some View {
        self
        #if os(watchOS)
            .background(Color.white.opacity(0.5))
        #else
            .background(.ultraThinMaterial)
        #endif
            .cornerRadius(cornderRadius ?? 0)
    }
}
