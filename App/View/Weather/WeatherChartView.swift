//
//  WeatherChartView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 9/30/23.
//

import SwiftUI

struct WeatherChartView<Item: WeatherItem>: View {
    let item: Item
    typealias ChartPoint = (Date, Double)

    var points: [ChartPoint] {
        item.data()
    }
    
    var now: ChartPoint? {
        (Date.now, item.data(from: .now))
    }
    
    var body: some View {
        ItemChart(
            chartPoints: item.data(),
            now: now,
            pointFor: item.data(from:),
            showZero: false
        )
    }
}

#Preview {
    WeatherChartView(item: Cloud(weather: MockData.weather))
}



