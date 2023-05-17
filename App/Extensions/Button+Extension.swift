//
//  Button+Extension.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI

extension Button where Label == Image {
    init(systemName: String,
         action: @escaping () -> Void) {
        self.init(action: action) {
            Image(systemName: systemName)
        }
    }
}
