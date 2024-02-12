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
    let intent: SkyIntent
    var sky: SkyEntity { intent.sky }
}

struct StatusProvider: AppIntentTimelineProvider {
    
    func placeholder(in context: Context) -> StatusEntry {
        StatusEntry(date: .now, intent: .init())
    }
    
    func snapshot(for intent: SkyIntent, in context: Context) async -> StatusEntry {
//        let sky = SkyData.shared.sky(named: intent.sky.title)
        return StatusEntry(date: .now, intent: intent)
    }
    
    func timeline(for intent: SkyIntent, in context: Context) async -> Timeline<StatusEntry> {
        var entries: [StatusEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let sky = SkyData.shared.sky(for: intent.sky.id)
//            let sky = SkyData.shared.sky(named: intent.sky.title)
            let entry = StatusEntry(date: entryDate, intent: intent)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)

    }
}
