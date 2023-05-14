//
//  WeatherItemView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI
import WeatherKit

struct WeatherItemView<W:SkyItem>: View {
    let item: W?
    let timezone: TimeZone?

    var body: some View {
        if let item {
            VStack(alignment: .leading, spacing: 10) {
                ItemHeader(title: item.title, symbolName: item.symbolName)
                Text(item.label ?? "--")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(item.subtitle ?? "--")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.horizontal)
            .transparent()
        }
    }
}

struct WeatherItemView_Previews: PreviewProvider {
    
    struct Item: SkyItem {
        var title: String = "Cloud"
        var symbolName: String = "cloud"
        var label: String? = "Cloudy"
        var subtitle: String? = "subtitle"
        var data: [WeatherChartData] {
            []
        }
        
        
    }
    static var previews: some View {
        WeatherItemView(item: Item(), timezone: timezone)
            .previewLayout(.sizeThatFits)
    }
}
