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

struct CelestialChart<C:CelestialBody>: View {
//    let events: CelestialEvents
    var celestial: C.Type
    let location: CLLocation
    let timezone: TimeZone
    var sunrise: Date?
    var sunset: Date?
    
    @State var selected: (date:Date, altitude:Double)?
    @State var isDragging = false
    private let service = CelestialService()
    
    let locations: [CelestialEvents.Location]

    var body: some View {
        Chart {
            ForEach(locations){
                LineMark(
                    x: .value("Time", $0.date),
                    y: .value("Altitude", $0.altitude)
                )
                .lineStyle(.init(lineWidth: 4))
                .foregroundStyle(isDragging ? .red:.blue)
            }
            RuleMark(y: .value("Average Sell", 0))
                .foregroundStyle(.white)

            if let selected {
                RuleMark(x: .value("Time", selected.date))
                    .foregroundStyle(.gray)
                    .annotation(position: .overlay) {
                        Text(selected.date.time(timezone))
                            .font(.caption)
                    }
                PointMark(
                    x: .value("Time", selected.date),
                    y: .value("Value", selected.altitude)
                )
                .foregroundStyle(.white)
            } else {
                PointMark(
                    x: .value("Time", Date.now),
                    y: .value("Value", value(for: Date.now))
                )
                .foregroundStyle(.white)
            }
        }
        .chartOverlay { proxy in
            GeometryReader { geometry in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // Convert the gesture location to the coordinate space of the plot area.
                                guard let plotFrame = proxy.plotFrame else {return}
                                let origin = geometry[plotFrame].origin
                                let location = CGPoint(
                                    x: value.location.x - origin.x,
                                    y: value.location.y - origin.y
                                )
                                // Get the x (date) and y (price) value from the location.
                                guard let (date, _) = proxy.value(at: location, as: (Date, Double).self) else {return}
                                guard let first = locations.first?.date, let last = locations.last?.date else {return}
                                if first < date, date < last {
                                    let celestialLocation = service.celestialLocation(celestial: celestial, at: self.location, at: date)
                                    self.selected = (date, celestialLocation.altitude)
                                } else {
                                    print(date.formatted())
                                }

                            }
                            .onEnded{ _ in
                                self.selected = nil
                            }
                    )
            }
        }
        .chartYAxis(.hidden)
    }
    
    
    
    func value(for date: Date) -> Double {
        let celestialLocation = service.celestialLocation(celestial: celestial, at: location, at: date)
        return celestialLocation.altitude
    }
}

extension CelestialChart {
    init(events: CelestialEvents, sunrise: Date?, sunset: Date?) where C == Planet {
        self.celestial = events.planet
        self.sunrise = sunrise
        self.sunset = sunset
        self.location = events.location
        self.timezone = events.timezone
        self.locations = events.locations
    }
}

#Preview {
    CelestialChart(celestial: Mars.self, location: MockData.locationNY, timezone: MockData.timezoneNY, locations: MockData.mars.locations)
}




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
