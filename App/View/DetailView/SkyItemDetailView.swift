//
//  SkyItemDetailView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import WeatherKit
import CoreLocation
import SwiftAA


enum DetailItem: String, CaseIterable, Identifiable {
    var id: String {rawValue}
    case cloud, percipitation, visibility, temperature, wind
    case percent
    case sun, moon, venus, mars, jupiter, saturn
    
    static let Celestials: [DetailItem] = [.venus, .mars, .jupiter, .saturn]
    
    var title: String {
        switch self {
        case .percent: return "Sky Visibility"
        default: return rawValue
        }
    }
    
    var chartData: any ItemChartData.Type {
        switch self {
        case .sun, .moon, .venus, .mars, .jupiter, .saturn: return CelestialEvents.Location.self
        default: return WeatherChartData.self
        }
    }
    
    func systemName(for day: DayWeather?) -> String {
        switch self {
        case .percipitation:
            return "drop"
        case .visibility:
            return "eye.fill"
        case .temperature:
            return "thermometer.medium"
        case .percent:
            return "moon.stars"
        case .sun:
            return day?.moon.nextEvent.type == .rise ? "sunrise":"sunset"
        case .moon:
            return day?.sun.nextEvent.type == .rise ? "moon.haze":"moon"
        case .venus, .mars, .jupiter, .saturn:
            return "circle"
        default: return rawValue
        }
    }
}

struct SkyItemDetailView: View {
    
    let weather: Weather?
    let events: [CelestialEvents]
    let location: CLLocation
    @State var item: DetailItem
    @State var selected: DayWeather?
    
    var hourly: [HourWeather] {
        guard let selected else {return []}
        let hourly = weather?.hourlyForecast.filter{$0.date.sameDay(as: selected.date) }
        return hourly ?? []
    }
    
    @State var time: Date = .now
    
    var body: some View {
        VStack {
            if let daily = weather?.dailyForecast.forecast {
                DetailDayScroll(daily: daily, selectedDay: $selected)
            }
            if let selected {
                Header(weather: selected, item: $item)
//                DetailChartView(hourly: hourly, item: item, location: location, time: $time)
//                .frame(height: 250)
            }
            Spacer()
        }
    }
    
    struct Header:View {
        let weather: DayWeather?
        @Binding var item: DetailItem
        
        var symbolName: String {
            item.systemName(for: weather)
        }
        
        var body: some View {
            HStack {
                VStack {
                    Image(systemName: symbolName)
                        .font(.largeTitle)
                    Text(item.title.capitalized)
                        .font(.largeTitle)

                }
                Spacer()
                #if !os(watchOS)
                Menu {
                    Picker("", selection: $item) {
                        ForEach(DetailItem.allCases) {
                            Label($0.title.capitalized, image: $0.systemName(for: weather))
                                .tag($0)
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: symbolName)
                        Image(systemName: "chevron.down")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .font(.title2)
                }
                #endif
            }
        }
    }
}

struct SkyItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SkyItemDetailView(weather: nil, events: events, location: sky.location, item: .venus)
    }
}
//
//switch item {
//case let celestialEvents as CelestialEvents:
//    Text("Celestial Events")
//    // Display specific views for CelestialEvents
//case let sunEvents as SunEvents:
//    Text("Sun Events")
//    // Display specific views for SunEvents
//case let moonEvents as MoonEvents:
//    Text("Moon Events")
//    // Display specific views for MoonEvents
//default:
//    Text("Other Weather Item")
//    // Display views for other WeatherItem conforming types
//}
