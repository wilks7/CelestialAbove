//
//  WeatherItemView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI
import WeatherKit

struct WeatherItemView<W:WeatherItem>: View {
    let item: W?
    let timezone: TimeZone?

    var body: some View {
        if let item {
            VStack(alignment: .leading, spacing: 10) {
                ItemHeader(title: W.title, symbolName: item.symbolName)
                Text(item.label)
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
    
    struct Item: WeatherItem {
        static var title: String = "Cloud"
        
        static var symbolName: String = "cloud"
        
        var label: String = "Cloudy"
        
        
    }
    static var previews: some View {
        WeatherItemView(item: Item(), timezone: timezone)
            .previewLayout(.sizeThatFits)
    }
}
