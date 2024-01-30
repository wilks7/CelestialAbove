//
//  WeatherDetailView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/2/23.
//

import SwiftUI
import WeatherKit
struct WeatherDetailView: View {
    typealias Item = (any WeatherItem)
    let weather: Weather
    @State var selected: Item
    
    var body: some View {
        NavigationStack {
            Text(selected.label)
                .navigationTitle(selected.label)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}




#Preview {
    WeatherDetailView(weather: MockData.weather, selected: Cloud(weather: MockData.weather))
}
