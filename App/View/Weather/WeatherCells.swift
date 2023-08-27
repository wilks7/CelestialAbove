////
////  WeatherCells.swift
////  CelestialAbove
////
////  Created by Michael Wilkowski on 5/16/23.
////
//
//import SwiftUI
//import WeatherKit
//
//struct WeatherCells: View {
//    
//    let day: DayWeather?
//    let hour: HourWeather?
//    let hourly: [HourWeather]
//    
//    let columns: [GridItem] = [
//        GridItem(.flexible(), spacing: 8),
//        GridItem(.flexible(), spacing: 8)
//    ]
//    
//    init(_ weather: Weather){
//        self.day = weather.today
//        self.hour = weather.hour
//        self.hourly = weather.hourly
//    }
//    
//    var body: some View {
//        if let hour, let day {
//            SkyGridCell(title: "Cloud", symbolName: "cloud") {
//                SmallView(item: Cloud(hour: hour, hourly, day: day))
//            }
//            SkyGridCell(title: "Wind", symbolName: "cloud") {
//                SmallView(item: Wind(hour: hour, hourly, day: day))
//            }
//            SkyGridCell(title: "Temperature", symbolName: "cloud") {
//                SmallView(item: Temperature(hour: hour, hourly, day: day))
//            }
//            SkyGridCell(title: "Precipitation", symbolName: "cloud") {
//                SmallView(item: Precipitation(hour: hour, hourly, day: day))
//            }
//            SkyGridCell(title: "Visibility", symbolName: "cloud") {
//                SmallView(item: Visibility(hour: hour, hourly, day: day))
//            }
//        }
//    }
//}
//
//#Preview {
//    Text("WeatherCells")
//}
//
////struct WeatherCells_Previews: PreviewProvider {
////    static var previews: some View {
////        WeatherCells()
////    }
////}
