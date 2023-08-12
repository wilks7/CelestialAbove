//
//  StatusProvider.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import SwiftUI
import Intents
import WidgetKit
import CoreData

struct StatusEntry: TimelineEntry {
    let date: Date
    let sky: Sky?
    let configuration: StatusIntent
}

struct StatusProvider: IntentTimelineProvider {
        
    var placeholder: StatusEntry {
        StatusEntry(date: .now, sky: nil, configuration: StatusIntent())
    }
    
    func placeholder(in context: Context) -> StatusEntry {
        placeholder
    }

    func getSnapshot(for configuration: StatusIntent, in context: Context, completion: @escaping (StatusEntry) -> ()) {
        Task {
            let entry = await getEntry(for: configuration)
            completion(entry)
        }
    }
    
    func getTimeline(for configuration: StatusIntent, in context: Context, completion: @escaping (Timeline<StatusEntry>) -> ()) {
        Task {
            let entry = await getEntry(for: configuration)
            let timeline = Timeline(entries: [entry], policy: .after(.now.startOfDay(Calendar.current.timeZone)))
            completion(timeline)
        }

    }
    
    func getEntry(for configuration: StatusIntent = StatusIntent()) async -> StatusEntry {
        if let uuidString = configuration.sky?.identifier {
            let sky = SkyData.find(id: uuidString)
            return StatusEntry(date: .now, sky: sky, configuration: configuration)
        } else {
            let skies:[Sky] = SkyData.allSkies()
            return StatusEntry(date: .now, sky: skies.first, configuration: configuration)
        }
    }
}
