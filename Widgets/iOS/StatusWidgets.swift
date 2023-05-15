//
//  iOS_Widgets.swift
//  iOS Widgets
//
//  Created by Michael Wilkowski on 5/12/23.
//

import WidgetKit
import SwiftUI
import Intents

struct StatusWidgetView : View {
    @Environment(\.widgetFamily) var widgetFamily
    let entry: StatusProvider.Entry
    var sky: Sky? {entry.sky}

    var body: some View {
        Group {
            switch widgetFamily {
            case .systemSmall:
                Text(sky?.title ?? "")
            case .systemMedium:
                Text(sky?.title ?? "")
            case .systemLarge:
                Text(sky?.title ?? "")
            case .systemExtraLarge:
                Text(sky?.title ?? "")
            case .accessoryCorner, .accessoryCircular, .accessoryRectangular, .accessoryInline:
                Text("No Widgets")
            @unknown default:
                Text("No Widgets")
            }
        }
    }
}

struct iOS_Widgets: Widget {
    let kind: String = "Status"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: StatusIntent.self, provider: StatusProvider()) { entry in
            StatusWidgetView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct StatusWidget_Previews: PreviewProvider {
    
    static var skyEntry: StatusEntry = .init(date: .now, sky: sky, configuration: StatusIntent())
    
    static var previews: some View {
//        #if os(iOS)
        Group {
            StatusWidgetView(entry: skyEntry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            StatusWidgetView(entry: skyEntry)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            StatusWidgetView(entry: skyEntry)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
            StatusWidgetView(entry: skyEntry)
                .previewContext(WidgetPreviewContext(family: .accessoryInline))
            StatusWidgetView(entry: skyEntry)
                .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            StatusWidgetView(entry: skyEntry)
                .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
        }
//            .environment(\.managedObjectContext, coreData.context)
//        #elseif os(macOS)
        Group {
            StatusWidgetView(entry: skyEntry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            StatusWidgetView(entry: skyEntry)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            StatusWidgetView(entry: skyEntry)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
//            .environment(\.managedObjectContext, coreData.context)
//        #endif
    }
}
