//
//  SkyItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import Foundation
import Charts
import WeatherKit
import SwiftUI

protocol Item: Identifiable {
    associatedtype ChartValue: ItemChartData
    associatedtype Object
    associatedtype ValueView: ItemValueView where ValueView.I == Self
    
    var title: String {get}
    var symbolName: String {get}
    var label: String? {get}
    var subtitle: String? {get}
    var data: [ChartValue] {get}
    static func data(for object: Object) -> ChartValue
}
protocol ItemValueView: View {
    associatedtype I:Item
    init(item: I)
}
extension Item {
    public var id: String { title }
    var title: String { String(describing: Self.self) }
}
protocol ItemChartData: Identifiable {
    associatedtype X: Comparable, Plottable
    associatedtype Y: PrimitivePlottableProtocol, Comparable
    static var xRange: ClosedRange<X>? {get}
    static var yRange: ClosedRange<Y>? {get}

    var reference: X {get}
    var value: Y {get}
}
extension ItemChartData {
    public var id: X {reference}
    static var xRange: ClosedRange<X>? { nil }
    static var yRange: ClosedRange<Y>? { nil }
}



protocol CelestialItem: Item where Object == CelestialService.Parameter, ChartValue == CelestialEvents.Location {
}
extension CelestialItem {
    static func data(for object: Object) -> CelestialEvents.Location {
        CelestialService().celestialLocation(object)
    }
}



