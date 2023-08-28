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


protocol WeatherItem: SkyItem where Data == WeatherChartData{
    init(hour: HourWeather, _ hourly: [HourWeather], day: DayWeather?)
    var value: Double { get }
}

extension WeatherItem {
    var title: String { String(describing: Self.self) }
    var symbolName: String { title.lowercased() }
    
    var constant: some View {
        Image(systemName: symbolName).resizable().aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
    
    func compact(_ alignment: HorizontalAlignment) -> some View {
        VStack(alignment: alignment) {
            Image(systemName: symbolName)
            Text(label ?? "--")
                .shadow(color: .red, radius: 20)
        }
    }

    
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
}
