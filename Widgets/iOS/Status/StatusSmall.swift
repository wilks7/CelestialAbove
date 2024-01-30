//
//  StatusSmall.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/7/23.
//

import WidgetKit
import SwiftUI
import AppIntents

struct StatusSmall: View {
    let sky: SkyEntity
    let event: PlanetEvents
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            StatusTitle(title: sky.title, timezone: sky.timezone)
            Text(0.6, format: .percent)
                .font(.largeTitle)
            Spacer()
            eventDetails
        }
    }
    
    var eventDetails: some View {
        VStack(alignment: .leading, spacing: 5) {
            Image(systemName: "circle.fill")
                .foregroundStyle(event.color)
//            Text(event.title)
                .font(.callout)
            if let transit = event.transit {
                Text(transit.time(sky.timezone))
                    .font(.caption)
            }
            HStack(spacing: 0) {
                if let rise = event.rise {
                    Image(systemName: "arrow.up")
                        .font(.caption2)
                    Text(rise.time(sky.timezone))
                        .font(.caption)

                }
                Spacer()
                if let set = event.set {
                    Image(systemName: "arrow.down")
                        .font(.caption2)
                    Text(set.time(sky.timezone))
                        .font(.caption)
                }
            }
        }
        .fontWeight(.semibold)
        .lineLimit(1)
        .minimumScaleFactor(0.7)
    }
}

#Preview(as: .systemSmall) {
    StatusWidgets()
} timeline: {
    StatusEntry(date: .now, intent: SkyIntent.newYork)
}
