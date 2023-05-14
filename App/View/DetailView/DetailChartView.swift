////
////  DetailChartView.swift
////  CelestialAbove
////
////  Created by Michael Wilkowski on 5/13/23.
////
//
//import SwiftUI
//import Charts
//import CoreLocation
//import WeatherKit
//import SwiftAA
//
//struct DetailChartView: View {
//    
//    let hourly: [HourWeather]
//    let item: DetailItem
//    let location: CLLocation
//    @Binding var time: Date
//    
//    var data: [any ChartData] {
//        hourly.map{ value(for: $0) }
//    }
//
//    var body: some View {
//        if let data = data as? [WeatherChartData] {
//            ChartView(data: data, time: $time, value: dataFor)
//        } else if let data = data as? [CelestialEvents.Location] {
//            ChartView(data: data, time: $time, value: dataFor)
//
//        }
//    }
//    
//    func dataFor(date: Date) -> Double {
//        guard let hour = hourly.first(where: {$0.date.hour == date.hour}) else {return 0}
//        let value = value(for: hour).value as? Double
//        return value ?? 0
//    }
//    
//    func value(for hour: HourWeather) -> any ChartData {
//        switch item {
//        case .cloud: return WeatherChartData(date: hour.date, value: hour.cloudCover)
//        case .percipitation: return WeatherChartData(date: hour.date, value: hour.precipitationChance)
//        case .temperature: return WeatherChartData(date: hour.date, value: hour.temperature.value)
//        case .wind: return WeatherChartData(date: hour.date, value: hour.wind.speed.value)
//        case .sun: return CelestialService().celestialLocation(for: Sun.self, at: location, at: hour.date)
//        case .moon: return CelestialService().celestialLocation(for: Moon.self, at: location, at: hour.date)
//        case .percent: return WeatherChartData(date: hour.date, value: Double(hour.percent.percent ?? 0))
//        case .visibility: return WeatherChartData(date: hour.date, value: hour.visibilityItem.visibility.value)
//        case .venus:
//            return CelestialService().celestialLocation(for: Venus.self, at: location, at: hour.date)
//        case .mars:
//            return CelestialService().celestialLocation(for: Mars.self, at: location, at: hour.date)
//        case .jupiter:
//            return CelestialService().celestialLocation(for: Jupiter.self, at: location, at: hour.date)
//        case .saturn:
//            return CelestialService().celestialLocation(for: Saturn.self, at: location, at: hour.date)
//
//        }
//    }
//}
//
////struct DetailEventChartView: View {
////    let event: CelestialEvents
////    let location: CLLocation
////    @Binding var time: Date
////
////    
////    var body: some View {
////        ChartView(data: event.locations, time: $time, value: getCelestialLocation)
////    }
////    
////    private func getCelestialLocation(_ date: Date) -> Double{
////        CelestialService().celestialLocation(for: event.celestial, at: location, at: date).altitude
////    }
////}
//
////struct DetailChartView_Previews: PreviewProvider {
////    static var previews: some View {
////        DetailChartView(hourly: <#T##[HourWeather]#>, item: <#T##DetailItem#>, location: <#T##CLLocation#>)
////    }
////}
