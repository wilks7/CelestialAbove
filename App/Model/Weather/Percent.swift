//
//  PercentItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/16/23.
//

import SwiftUI
import WeatherKit

struct Percent: WeatherItem {
    let weather: Weather
    static var systemName: String { "moon.stars" }

    var percent: Double? {
        weather.hour?.percent ?? 0.6
    }
    var sunEvents: SunEvents? {
        weather.today?.sun
    }
    
    var label: String {
        nextEvent(rise: sunEvents?.sunrise, set: sunEvents?.sunset, transit: sunEvents?.solarNoon).date?.time() ?? "--"
    }
    
    var detail: String? { nil }
    
    var compact: some View {
        PercentView(percent: percent ?? 0, size: 42)
    }
    
    func data(for hour: HourWeather) -> (Date,Double) {
        (hour.date, hour.percent)
    }

}



// MARK: View
struct PercentView: View {
    
    let percent: Double
    let size: CGFloat
    var weight: Font.Weight = .light
    
    var symbolSize: CGFloat { size / ( size < 30 ? 1.75 : 2.5) }
    
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(percent, format: .percent)
                .font(.system(size: size, weight: weight))
            Text("%")
                .padding(.top, size/10)
                .font(.system(size: symbolSize, weight: .semibold))
        }
        .offset(y: -4)
        .offset(x: symbolSize/4)

    }
    
    struct Gauge: View {
        let percent: Double?

        var body: some View {
            if let percent = percent {
                SwiftUI.Gauge(value: percent) {}
                    .gaugeStyle(.accessoryLinear)
                    .tint(.white)
                    .shadow(radius: 10)
                    .padding(.horizontal, 30)
            }
        }
    }
}

struct SkyViewPercent_Previews: PreviewProvider {
    static var previews: some View {
        PercentView(percent: 0.5, size: 46)
        PercentView(percent: 2.0, size: 46)
    }
}
