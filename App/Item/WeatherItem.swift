//
//  WeatherItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import WeatherKit
import SwiftUI
import Charts


struct WeatherChartData: ChartData {
    let reference: Date
    let value: Double
    
}

struct WeatherParam {
    let hour: HourWeather
    let hourly: [HourWeather]
    let day: DayWeather
}

protocol WeatherItem: SkyItem where Data == WeatherChartData{
    init(hour: HourWeather, _ hourly: [HourWeather], day: DayWeather?)
    init?(_ weather: Weather)
    var chartData: [WeatherChartData] { get }
    var value: Double { get }
}
extension WeatherItem {
    
    init?(_ weather: Weather){
        guard let hour = weather.hour, let day = weather.today else {return nil}
        self.init(hour: hour, weather.hourly, day: day)
    }
    
    init?(_ param: Sky) {
        guard let weather = param.weather else {return nil}
        self.init(weather)
    }
    
    var symbolName: String { title.lowercased() }
    var constant: some View {
        WeatherValueView(symbolName: symbolName)
    }
    
    func compact(_ alignment: HorizontalAlignment) -> some View {
        VStack(alignment: alignment) {
            Image(systemName: symbolName)
            Text(label ?? "--")
                .shadow(color: .red, radius: 20)
        }
    }

    func point(for date: Date) -> WeatherChartData? {
        chartData.first{$0.reference.sameDay(as: date)}
    }
}


protocol HourData {
    static var symbolName: String {get}
    static var title: String {get}
    static func data(for hour: HourWeather) -> Double
}

struct WeatherValueView: View {
    let symbolName: String
    var body: some View {
        Image(systemName: symbolName).resizable().aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}


//extension WeatherItem {
//
//    var now: HourWeather? { hourly.now }
//
//    var points: [WeatherChartData] {
//        hourly.map{ point(for: $0) }
//    }
//
//
//
//    func point(for item: Data.Reference) -> Data {
//        let data = data(for: item)
//        return .init(reference: item.date, value: data)
//    }
//}

