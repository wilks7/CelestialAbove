//
//  ChartView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import Charts

protocol ItemChartView: View {
    associatedtype T: ItemChartData
//    associatedtype C: View
    var data: [T] {get}
}

struct ItemChart<I:Item>: View {
    typealias ChartData = I.ChartValue
    let item: I
    var data: [I.ChartValue] {
        item.data
    }
    
    @State private var selected: I.ChartValue?

    var body: some View {
        Chart {
            if let selected {
                RuleMark(x: .value("Time", selected.reference))
                    .foregroundStyle(.gray)
            }
            ForEach(data){
                LineMark(
                    x: .value("Time", $0.reference),
                    y: .value("Value", $0.value),
                    series: .value("Alt", "A")
                )
                .lineStyle(.init(lineWidth: 4))
            }
            if let selected {
                PointMark(
                    x: .value("Time", selected.reference),
                    y: .value("Value", selected.value)
                )
                .foregroundStyle(.white)
            } else if let item = item as? CelestialEvents {
                PointMark(
                    x: .value("Time", Date.now),
                    y: .value("Value", CelestialService().celestialLocation(.init(celestial: item.celestial, location: item.location)).altitude )
                )
                .foregroundStyle(.white)
            }
        }
    }
}



//import SwiftAA
//struct ChartView_Previews: PreviewProvider {
//    static func test(date: Date) -> Double {
//        CelestialService().celestialLocation(for: Mars.self, at: sky.location, at: date).altitude
//    }
//    static var previews: some View {
//        ChartView(data: event.data, time: .constant(.now))
//    }
//}
