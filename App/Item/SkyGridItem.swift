//
//  SkyGridItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/27/23.
//

import SwiftUI

protocol SkyGridItem {
    associatedtype Chart: View
    associatedtype Detail: View
    static var title: String {get}
    static var symbolName: String {get}
}
