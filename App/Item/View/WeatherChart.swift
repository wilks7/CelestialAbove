////
////  WeatherChart.swift
////  CelestialAbove
////
////  Created by Michael Wilkowski on 5/16/23.
////
//
//import SwiftUI
//import Charts
//import WeatherKit
//
//struct WeatherChart: View {
//    typealias W = WeatherChartData
//    let points: [W]
//    @State var selected: W?
//
//    
//    var body: some View {
//        Chart {
//            if let selected {
//                RuleMark(x: .value("Time", selected.reference))
//                    .foregroundStyle(.gray)
//            }
//            ForEach(points){
//                LineMark(
//                    x: .value("Time", $0.reference),
//                    y: .value("Value", $0.value),
//                    series: .value("Alt", "A")
//                )
//                .lineStyle(.init(lineWidth: 4))
//            }
//            if let selected {
//                PointMark(
//                    x: .value("Time", selected.reference),
//                    y: .value("Value", selected.value)
//                )
//                .foregroundStyle(.white)
//            } else if let point = point(for: Date.now)  {
//                PointMark(
//                    x: .value("Time", Date.now),
//                    y: .value("Value", point.reference)
//                )
//                .foregroundStyle(.white)
//            }
//        }
//    }
//    
//    private func point(for date: Date) -> W? {
//        points.first(where: {$0.reference.hour == date.hour })
//    }
//
//}
////struct WeatherChart_Previews: PreviewProvider {
////    static var previews: some View {
////        HourChart(data: event.locations)
////    }
////}
