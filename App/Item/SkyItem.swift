//
//  SkyItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import Charts

protocol SkyItem {
    associatedtype Data: ChartData
    associatedtype Constant: View
    associatedtype Compact: View

    var title: String {get}
    var symbolName: String {get}
    
    var chartData: [Data] {get}
    
    var label: String? {get}
    var subtitle: String? {get}
    var detail: String? {get}
    var detailSubtitle: String? {get}
        
    var constant: Constant { get }
    func compact(_ alignment: HorizontalAlignment) -> Compact
        
    init?(_ param: Sky)
}
extension SkyItem {
    public var id: String { title }
    
    var subtitle: String? {nil}
    var detail: String? {nil}
    var detailSubtitle: String? {nil}
}

protocol ChartData: Identifiable {

    associatedtype X: Comparable, Plottable
    associatedtype Y: PrimitivePlottableProtocol, Comparable
    var xRange: ClosedRange<X>? {get}
    var yRange: ClosedRange<Y>? {get}

    var reference: X {get}
    var value: Y {get}
    
}
extension ChartData {
    public var id: X {reference}
    var xRange: ClosedRange<X>? { nil }
    var yRange: ClosedRange<Y>? { nil }
    var xAxis: String {"Time"}
    var yAxis: String {"Value"}
}
