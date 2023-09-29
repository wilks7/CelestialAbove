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
    
    var weather: Weather? { sky.weather }
    
    var events: [CelestialEvents] {
        CelestialService().fetchPlanetEvents(at: sky.location, in: sky.timezone, title: sky.title)
    }
        
    var body: some View {
        HStack {
            Text(sky.title)
                .font(.largeTitle)
            Spacer()
            Text(sky.weather?.today?.date.formatted() ?? "")
        }
        .padding()
//        if let weather = weather, let event = events.first {
//            MediumView(title: sky.title, timezone: sky.timezone,
//                        topTrailing: Percent(weather: weather),
//                        bottomLeading: event,
//                        bottomTrailing: Cloud(weather: weather))
//
//        } else if let first = events.first, let last = events.last {
//            MediumView(title: sky.title, timezone: sky.timezone,
//                        topTrailing: first,
//                        bottomLeading: first,
//                        bottomTrailing: last)
//        }

    }
    
    struct MediumView<TopTrailing: View, BottomLeading: View, BottomTrailing: View>: View {
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
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
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

//    extension MediumView {
//        init<TT:SkyItem, BL: SkyItem, BT: SkyItem>(
//            title: String,
//            timezone: TimeZone,
//            topTrailing: TT,
//            bottomLeading: BL,
//            bottomTrailing: BT
//        ) where TopTrailing == TT.Compact, BottomLeading == BL.Compact, BottomTrailing == BT.Compact {
//            self.topTrailing = topTrailing.compact
//            self.bottomLeading = bottomLeading.compact
//            self.bottomTrailing = bottomTrailing.compact
//            self.title = title
//            self.timezone = timezone
//        }
//        
//    }

}



#Preview {
    ModelPreview {
        var sky: Sky = $0
//        sky.events = MockData.events
//        sky.weather = MockData.weather
        return SkyCellView(sky: sky)
    }
}
