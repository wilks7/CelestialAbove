//
//  WeatherCells.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/16/23.
//

import SwiftUI
import WeatherKit

struct WeatherCells: View {
    
    let day: DayWeather?
    let hour: HourWeather?
    let hourly: [HourWeather]
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    init(_ weather: Weather){
        self.day = weather.today
        self.hour = weather.hour
        self.hourly = weather.hourly
    }
    
    var body: some View {
        if let hour, let day {
            LazyVGrid(columns: columns, spacing: 8) {
                SkyItemView<Cloud>(hour: hour, hourly, day: day)
                SkyItemView<Wind>(hour: hour, hourly, day: day)
                SkyItemView<Temperature>(hour: hour, hourly, day: day)
                SkyItemView<Precipitation>(hour: hour, hourly, day: day)
                SkyItemView<Visibility>(hour: hour, hourly, day: day)
            }
        }
    }
}

#Preview {
    Text("WeatherCells")
}

//struct WeatherCells_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherCells()
//    }
//}
