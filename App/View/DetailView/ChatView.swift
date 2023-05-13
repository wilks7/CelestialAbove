//
//  ChartView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import Charts


struct WeatherChartData:ChartData {
    var date: Date
    var value: Double
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

struct ChartView<D:ChartData>: View {
    let data: [D]
    @Binding var time: Date
    var value: (_ date: Date) -> D.T
    
    @State private var selected: D?

    
    
    var body: some View {
        Chart {
            if let selected {
                RuleMark(x: .value("Time", selected.date))
                    .foregroundStyle(.gray)
            }
            ForEach(data){
                LineMark(
                    x: .value("Time", $0.date),
                    y: .value("Value", $0.value),
                    series: .value("Alt", "A")
                )
                .lineStyle(.init(lineWidth: 4))
            }
            if let selected {
                PointMark(
                    x: .value("Time", selected.date),
                    y: .value("Value", selected.value)
                )
                .foregroundStyle(.white)
            } else {
                PointMark(
                    x: .value("Time", time),
                    y: .value("Value", value(time))
                )
                .foregroundStyle(.white)
            }
        }
    }
}

import SwiftAA
struct ChartView_Previews: PreviewProvider {
    static func test(date: Date) -> Double {
        CelestialService().celestialLocation(for: Mars.self, at: sky.location, at: date).altitude
    }
    static var previews: some View {
        ChartView(data: event.locations, time: .constant(.now), value: test)
    }
}
