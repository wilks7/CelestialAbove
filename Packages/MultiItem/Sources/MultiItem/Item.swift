//
//  SkyItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/1/23.
//

import Foundation
import SwiftUI
import Charts

public protocol Item {
    associatedtype Glyph: View
    var title: String {get}
    var glyph: Glyph {get}

    var subtitle: String? {get}
}
public extension Item {
    var symbolName: String? {nil}
    var subtitle: String? {nil}
}





