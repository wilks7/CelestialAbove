//
//  CelestialChart.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/16/23.
//

import SwiftUI
import Charts
import CoreLocation
import SwiftAA

struct CelestialChart: View {
    let events: CelestialEvents
    var sunrise: Date
    var sunset: Date
    
    @State var selected: CelestialEvents.Location?
    @State var isDragging = false
    private let service = CelestialService()

    var body: some View {
        Chart {
            if let selected {
                RuleMark(x: .value("Time", selected.date))
                    .foregroundStyle(.gray)
            }
            ForEach(events.locations){
                LineMark(
                    x: .value("Time", $0.date),
                    y: .value("Altitude", $0.altitude)
                )
                .lineStyle(.init(lineWidth: 4))
                .foregroundStyle(isDragging ? .red:.blue)
            }
        }
        .gesture(
            DragGesture()
                .onChanged{_ in isDragging = true}
                .onEnded{_ in isDragging = false }
        )

//            RuleMark(x: .value("Time", sunrise))
//                .foregroundStyle(.gray)
//                .annotation(position: .bottom, spacing: 0) {
//                    Image(systemName: "sunrise")
////                    Text(events.locations.first?.date.formatted() ?? "First")
//                }
//            RuleMark(x: .value("Time", sunset))
//                .foregroundStyle(.gray)
//                .annotation(position: .bottom, spacing: 0) {
//                    Image(systemName: "sunset")
//                    Text(sunrise.formatted())
//                }
//            if let selected {
//                selected.point
//                .foregroundStyle(.white)
//            }
//            else {
//                PointMark(
//                    x: .value("Time", Date.now),
//                    y: .value("Value", value(for: Date.now).altitude)
//                )
//                .foregroundStyle(.white)
//            }
//            RuleMark(y: .value("Horizon", 0))
//                .foregroundStyle(.white)
//        }
//        .chartXAxis {
//            AxisMarks(format: .dateTime.hour(), values: [Date.now.startOfDay(), Date.now.endOfDay()])
//        }
//        .chartYAxis {
//            AxisMarks(values: [-100, -50, 50, 100])
//        }
////        .chartBackground(content: { proxy in
////            Color.red
////        })
//        .chartPlotStyle { chartContent in
//            chartContent
//                .background(Color.red.opacity(0.2))
////                .frame(height: 32)
//        }
    }
    
    
    
    func value(for date: Date) -> CelestialEvents.Location {
        service.celestialLocation(for: events.planet, at: events.location, at: date)
    }
}

struct CelestialChart_Previews: PreviewProvider {
    static var previews: some View {
        let sunrise = MockData.mars.locations.first!.date.startOfDay().addingTimeInterval(60*60*7)
        let sunset = MockData.mars.locations.first!.date.endOfDay().addingTimeInterval(-60*60*7)

        CelestialChart(events: MockData.mars, sunrise: sunrise, sunset: sunset)
            .padding()
    }
}
