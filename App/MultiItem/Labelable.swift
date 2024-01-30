//
//  Labelable.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/4/23.
//

import Foundation

protocol Labelable {
    var label: String {get}
    var symbolName: String? {get}
    var sublabel: String? {get}
}
extension Labelable {
    var sublabel: String? {nil}
}
