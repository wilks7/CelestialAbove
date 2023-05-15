//
//  SkyView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI

struct SkyView: View {
    @EnvironmentObject var navigation: NavigationManager
    @ObservedObject var sky: Sky
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                header
                ForEach(sky.events) { events in
                    SkyItem(events, .medium)
                        .transparent()
                }
                if let weather = sky.weather {
                    LazyVGrid(columns: columns, spacing: 8) {
                        SkyItem<CloudItem>(weather).transparent()
                        SkyItem<WindItem>(weather).transparent()
                        SkyItem<TemperatureItem>(weather).transparent()
                        SkyItem<PrecipitationItem>(weather).transparent()
                        SkyItem<Visibility>(weather).transparent()

                    }
                }
            }
            .padding(.horizontal)
        }
        .environmentObject(sky)
        .scrollContentBackground(.hidden)
//            HStack {
//                WeatherItemView(item: sky.weather?.today?.sun, timezone: sky.timezone)
//                WeatherItemView(item: sky.weather?.today?.moon, timezone: sky.timezone)
//            }


//            CelestialCharts(events: sky.events, location: sky.location, weather: sky.weather)
//            ForecastView(forecast: sky.weather?.hourly, timezone: sky.timezone)
//            ForecastView(forecast: sky.weather?.daily, timezone: sky.timezone, alignment: .vertical)
//            HStack {
//                WeatherItemView(item: sky.weather?.today?.condition, timezone: sky.timezone)
//                WeatherItemView(item: sky.weather?.today?.wind, timezone: sky.timezone)
//            }
//            HStack {
//                WeatherItemView(item: sky.weather?.today?.temperatureItem, timezone: sky.timezone)
//                WeatherItemView(item: sky.weather?.today?.precipitationItem, timezone: sky.timezone)
//            }
//        }
        .navigationTitle(sky.title)

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
