//
//  PercentItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/16/23.
//

import SwiftUI
import WeatherKit

struct Percent: WeatherItem {
    let percent: Double
    var value: Double { percent }
    let sunEvents: SunEvents?
    
    let chartData: [WeatherChartData]
    
    init(hour: HourWeather, _ hourly: [HourWeather], day: DayWeather?) {
        self.percent = hour.percent
        self.sunEvents = day?.sun
        self.chartData = hourly.map{ .init(reference: $0.date, value: $0.percent) }
    }
    
    var symbolName: String = "percent"
    var label: String? { sunEvents?.nextTime }
    
    func compact(_ alignment: HorizontalAlignment) -> some View {
        VStack(alignment: alignment) {
            PercentView(percent: percent, size: 42)
        }
    }
}


// MARK: View
struct PercentView: View {
    
    let percent: Double
    let size: CGFloat
    var weight: Font.Weight = .light
    
    var symbolSize: CGFloat { size / ( size < 30 ? 1.75 : 2.5) }
    
    var body: some View {
        Group {
            if let string = percent.percentString?.dropLast(1) {
                HStack(alignment: .top, spacing: 0) {
                    Text(string)
                        .font(.system(size: size, weight: weight))
                    Text("%")
                        .padding(.top, size/10)
                        .font(.system(size: symbolSize, weight: .semibold))
                }
                .offset(y: -4)
                .offset(x: symbolSize/4)
            } else {
                Text("--")
                    .font(.system(size: size))
            }
        }
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
