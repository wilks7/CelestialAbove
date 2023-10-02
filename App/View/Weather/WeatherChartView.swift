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

    @State private var selected: ChartPoint? = nil
    var points: [ChartPoint] {
        item.data()
    }
    func checkFor(_ date: Date) -> Bool {

        #warning("better guard")
        if let first = points.first?.0,
           let last = points.last?.0 {
            
            return date >= first && date <= last
        } else {
            return false
        }
    }
    
    var now: ChartPoint? {
        (Date.now, item.data(from: .now))
    }
    
    var body: some View {
        ItemChart(chartPoints: points, selected: $selected)
            .selectOverlay(selected: $selected,
                           pointFor: item.data(from:),
                           checkFor: checkFor
            )
    }
}

#Preview {
    WeatherChartView(item: Cloud(weather: MockData.weather))
}



