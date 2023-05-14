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

protocol SkyItemView: View {
    associatedtype Item: SkyItem
    associatedtype Compact: View
    associatedtype Medium: View
    associatedtype Full: View
    
    var item: Item? {get}
    
    @ViewBuilder
    var compact: Compact {get}
    var medium: Medium {get}
    var full: Full {get}
}

protocol SkyItemObject {
//    associatedtype ChartValue: ChartData
}

protocol ChartData: Identifiable {
    associatedtype T: PrimitivePlottableProtocol, Comparable
    static var range: ClosedRange<T>? {get}
    var date: Date {get}
    var value: T {get}
}
extension ChartData {
    var id: Date {date}
    static var range: ClosedRange<T>? { nil }
}

protocol SkyItem: Identifiable {
    associatedtype ChartValue: ChartData
//    associatedtype Object: SkyItemObject
//    associatedtype View: SkyItemView
//    var range: ClosedRange<D> {get}
    var title: String {get}
    var symbolName: String {get}
    var label: String? {get}
    var subtitle: String? {get}
    var data: [ChartValue] {get}
//    var view: View {get}
}

protocol WeatherItem: SkyItem {
    var hourly: [HourWeather] {get}
    init(_ weather: Weather?)
    static func data(for hour: HourWeather) -> WeatherChartData
}
extension WeatherItem {
    var data: [WeatherChartData] {
        hourly.map{ Self.data(for: $0) }
    }
}
extension SkyItem {
    var title: String { String(describing: Self.self) }
    public var id: String { title }
}
