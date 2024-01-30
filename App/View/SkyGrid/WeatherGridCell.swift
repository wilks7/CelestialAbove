//
//  WeatherGridCell.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/4/23.
//

import SwiftUI
import WeatherKit


struct WeatherItems: View {
    let weather: Weather?
    var body: some View {
        if let weather {
            GridRow {
                WeatherGridCell<Cloud>(weather: weather)
                WeatherGridCell<Wind>(weather: weather)
            }
            GridRow {
                WeatherGridCell<Precipitation>(weather: weather)
                WeatherGridCell<Temperature>(weather: weather)
            }
            GridRow {
                WeatherGridCell<Visibility>(weather: weather)
                WeatherGridCell<Percent>(weather: weather)
            }
        }
    }
}

fileprivate extension WeatherItems {
    struct WeatherGridCell<W:WeatherItem>: View {
        let item: W
            
        init(weather: Weather) {
            self.item = W(weather: weather)
        }
        
        var body: some View {
            SkyGridRow(title: W.title, symbolName: item.symbolName) {
                ItemSmall(label: item.label, detail: item.detail) {
                    item.glyph
                }
            } chart: {
                WeatherChartView(item: item)
            } sheet: {
                WeatherDetailView(weather: item.weather, selected: item)
            }
        }
    }
}
 

#Preview {
    Grid {
        WeatherItems(weather: MockData.weather)
    }
}

#Preview {
    WeatherItems.WeatherGridCell<Cloud>(weather: MockData.weather)
}
