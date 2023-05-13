//
//  SkyView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI

struct SkyView: View {
    @ObservedObject var sky: Sky
    
    var body: some View {
        SkyContentView(color: sky.color, header: header ) {
            HStack {
                WeatherItemView(item: sky.weather?.today?.sun, timezone: sky.timezone)
                WeatherItemView(item: sky.weather?.today?.moon, timezone: sky.timezone)
            }
            CelestialCharts(events: sky.events, location: sky.location)
            ForecastView(forecast: sky.weather?.hourly, timezone: sky.timezone)
            ForecastView(forecast: sky.weather?.daily, timezone: sky.timezone, alignment: .vertical)
            HStack {
                WeatherItemView(item: sky.weather?.today?.condition, timezone: sky.timezone)
                WeatherItemView(item: sky.weather?.today?.wind, timezone: sky.timezone)
            }
            HStack {
                WeatherItemView(item: sky.weather?.today?.temperatureItem, timezone: sky.timezone)
                WeatherItemView(item: sky.weather?.today?.precipitationItem, timezone: sky.timezone)
            }
        }
    }
    
    var header: some View {
        VStack {
            HStack {
                Spacer()
                Text("90%")
                    .font(.system(size: 82))
                Spacer()
            }
        }
    }
}

struct SkyView_Previews: PreviewProvider {
    static var previews: some View {
        SkyView(sky: sky)
    }
}
