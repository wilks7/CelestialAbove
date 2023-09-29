//
//  SkyCellView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/17/23.
//

import SwiftUI
import WeatherKit

struct SkyCellView: View {
    
    let sky: Sky
    
    var events: [CelestialEvents] {
        CelestialService().fetchPlanetEvents(at: sky.location, in: sky.timezone, title: sky.title)
    }
        
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0){
                    SkyTitle(title: sky.title)
                    Text( Date.now.time(sky.timezone) )
                        .font(.footnote.weight(.semibold))
                }
                Spacer()
                
                if let percent = sky.weather?.daily.first?.percent {
                    Text(percent, format: .percent)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }

            }
            .padding(.bottom)
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    if let title = events.first?.title {
                        PlanetView(celestial: title)
                            .frame(width: 30, height: 30)
                        Text(title)
                    }
                    
                }
                Spacer()
                VStack(alignment: .trailing) {
                    if let hour = sky.weather?.hourly.first {
                        Text(hour.condition.description.capitalized)
                        Image(systemName: hour.symbolName)
                    }

                }
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
        .foregroundColor(.white.opacity(0.9))
        .padding(.horizontal)
        .padding(.vertical, 8)
        
    }


    struct SkyTitle: View {
            
        let title: String
        var isCurrent: Bool = false
        var font: Font? = nil
        var weight: Font.Weight = .bold
        var alignment: HorizontalAlignment = .leading

        var body: some View {
            HStack(alignment: .top) {
                if isCurrent && alignment == .trailing {
                    image
                }
                Text(title)
                if isCurrent && alignment == .leading {
                    image
                }
            }
            .font(font)
            .fontWeight(weight)
        }

        var image: some View {
            Image(systemName: "location.fill")
                .scaleEffect(0.8)
        }
    }


}

extension SkyCellView {
    
    struct CellView<TopTrailing: View, BottomLeading: View, BottomTrailing: View>: View {
        let title: String
        let timezone: TimeZone

        @ViewBuilder
        var topTrailing: TopTrailing
        
        @ViewBuilder
        var bottomTrailing: BottomTrailing
        
        @ViewBuilder
        var bottomLeading: BottomLeading
            
        var body: some View {
            VStack(spacing: 0) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 0){
                        SkyTitle(title: title)
                        Text( Date.now.time(timezone) )
                            .font(.footnote.weight(.semibold))
                    }
                    Spacer()
                    
                    topTrailing
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                .padding(.bottom)
                HStack(alignment: .bottom) {
                    bottomLeading
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Spacer()
                    bottomTrailing
                }
            }
            .foregroundColor(.white.opacity(0.9))
        }
    }
}



#Preview {
    ModelPreview {
        var sky: Sky = $0
//        sky.events = MockData.events
//        sky.weather = MockData.weather
        return SkyCellView(sky: sky)
    }
}
