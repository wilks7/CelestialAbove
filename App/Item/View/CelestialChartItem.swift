//
//  CelestialChartItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/22/23.
//

import SwiftUI

struct CelestialChartItem: View {
    let event: CelestialEvents
    var sunrise: Date?
    var sunset: Date?
    
    enum ViewType { case detail, chart }
    @State var type: ViewType = .chart
    
    var body: some View {
        SkyGridCell(title: event.title, symbolName: event.symbolName) {
            Group {
                if type == .detail {
                    HStack {
                        event.constant
                            .frame(width: 70, height: 70)
                        Spacer()
                        VStack {
                            Text(event.label ?? "--")
                            Text(event.subtitle ?? "--")
                            Text(event.detail ?? "--")
                        }
                    }
                    .padding(.horizontal)
                }
                else if let sunrise, let sunset {
                    CelestialChart(events: event, sunrise: sunrise, sunset: sunset)
                }
            }
            .onTapGesture {
                withAnimation {
                    self.type = self.type == .detail ? .chart : .detail
                }
            }        }
    }

}

#Preview {
    CelestialChartItem(event: MockData.mars, sunrise: MockData.sunEvents.sunrise, sunset: MockData.sunEvents.sunset)
        .frame(height: 200)
}

#Preview {
    CelestialChartItem(event: MockData.mars, sunrise: MockData.sunEvents.sunrise, sunset: MockData.sunEvents.sunset)
        .frame(width: 164, height: 164)
}
