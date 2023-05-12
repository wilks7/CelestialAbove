//
//  Color+Extension.swift
//  CelestialAbove
//
//  Created by Michael on 5/12/23.
//

import SwiftUI

extension Color {
    static let random =  Color(
        red: .random(in: 0...1),
        green: .random(in: 0...1),
        blue: .random(in: 0...1)
    )
}
