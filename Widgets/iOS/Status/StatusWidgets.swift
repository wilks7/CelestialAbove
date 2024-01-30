//
//  iOS_Widgets.swift
//  iOS Widgets
//
//  Created by Michael Wilkowski on 5/12/23.
//

import WidgetKit
import SwiftUI
import AppIntents
import WeatherKit

struct StatusWidgets: Widget {
    let kind: String = "Status"
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: SkyIntent.self,
            provider: StatusProvider()
        ) { entry in
            StatusWidgetView(entry: entry)

        }
        .supportedFamilies( [.systemSmall, .systemMedium, .systemLarge] )
        .configurationDisplayName("Sky Status")
        .description("The night sky conditions.")
    }
}

struct StatusWidgetView : View {
    @Environment(\.widgetFamily) var widgetFamily
    let entry: StatusEntry
    
    var intent: SkyIntent {
        entry.intent
    }
    
    var sky: SkyEntity {
        intent.sky
    }
    
    var events: [PlanetEvents] {
//        guard let sky = entry.sky else {return []}
        return CelestialService.fetchPlanetEvents(at: sky.location, in: sky.timezone, title: sky.title)
    }
    
    var planetEvent: PlanetEvents? {
        guard let planet = intent.planet
        else { return events.first }
        
        return CelestialService.createEvent(for: planet.celestial, at: sky.location, in: sky.timezone, date: entry.date)

    }
    
    
    var body: some View {
        if let event = planetEvent {
            Group {
                switch widgetFamily {
                case .systemSmall:
                    StatusSmall(sky: sky, event: event)
                case .systemMedium:
                    StatusMedium(sky: sky, display: intent.display, event: event)
                case .systemLarge:
                    Text(sky.title)
                case .systemExtraLarge:
                    Text(sky.title)
                case .accessoryCorner, .accessoryCircular, .accessoryRectangular, .accessoryInline:
                    Text("No Widgets")
                @unknown default:
                    Text("No Widgets")
                }
            }
            .foregroundStyle(.white)
            .containerBackground(for: .widget){
                SkyBackgroundGradient(time: entry.date, sunEvents: nil, timezone: sky.timezone)
            }

        } else {
            Text("No Sky")
        }
    }
    
}

#Preview(as: .systemSmall) {
    StatusWidgets()
} timeline: {
    StatusEntry(date: .now, intent: SkyIntent.newYork)
}
