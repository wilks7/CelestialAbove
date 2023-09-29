//
//  CelestialChart.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 9/29/23.
//

import SwiftUI
import Charts

struct CelestialChart: View {
    typealias ChartPoint = (date: Date, altitude: Double)
    
    let chartPoints: [ChartPoint]
    var now: ChartPoint? = nil

    @State var selected: ChartPoint? = nil

    var body: some View {
        Chart {
            ForEach(chartPoints, id: \.self.0){
                LineMark(
                    x: .value("Time", $0.0),
                    y: .value("Value", $0.1)
                )
                .lineStyle(.init(lineWidth: 4))
            }
            RuleMark(y: .value("Value", 0))
                .foregroundStyle(.white)
            if let selected {
                RuleMark(x: .value("Time", selected.0))
                    .foregroundStyle(.gray)
                    .annotation(position: .overlay) {
                        Text(selected.0.formatted())
                            .font(.caption)
                    }
                PointMark(
                    x: .value("Time", selected.0),
                    y: .value("Value", selected.1)
                )
                .foregroundStyle(.white)
            } else if let now {
                PointMark(
                    x: .value("Time", now.0),
                    y: .value("Value", now.1)
                )
                .foregroundStyle(.white)
            }
        }
        .chartYAxis(.hidden)

    }
}

//#Preview {
//    CelestialChart()
//}
