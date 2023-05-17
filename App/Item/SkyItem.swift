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
    
    func point(for date: Date) -> Data?
    
    init?(_ param: Sky)
}
extension SkyItem {
    
    public var id: String { title }
    var title: String { String(describing: Self.self) }
    var label: String? {symbolName}
    var subtitle: String? {symbolName}
    var detail: String? {symbolName}
    var detailSubtitle: String? {symbolName}
    
    var constant: some View {
        Text(label ?? "--").font(.title)
    }
    

}

protocol ChartData: Identifiable {

    associatedtype X: Comparable, Plottable
    associatedtype Y: PrimitivePlottableProtocol, Comparable
    var xRange: ClosedRange<X>? {get}
    var yRange: ClosedRange<Y>? {get}

    var reference: X {get}
    var value: Y {get}
    
    };extension ChartData {
    
    public var id: X {reference}
    var xRange: ClosedRange<X>? { nil }
    var yRange: ClosedRange<Y>? { nil }
}

extension ChartData {
    var point: PointMark {
        PointMark(
            x: .value("Time", self.reference),
            y: .value("Value", self.value)
        )
    }
    
    var linemark: LineMark {
        LineMark(
            x: .value("Time", self.reference),
            y: .value("Value", self.value),
            series: .value("Alt", "A")
        )
    }
    
    var rulemark: RuleMark {
        RuleMark(x: .value("Time", self.reference))
    }
}




