//
//  Widget1.swift
//  Widget1
//
//  Created by Gregory Keeley on 9/16/20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct Widget1EntryView : View { // View of the widget
    var entry: Provider.Entry
    
    var body: some View { // Content of view
        Text(entry.date, style: .date)
        Text(entry.date, style: .time)
        Image(systemName: "photo")
    }
}

@main
struct Widget1: Widget {
    let kind: String = "Widget1"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Widget1EntryView(entry: entry)
        }
        .configurationDisplayName("My Widget") // Display name in the widget gallery
        .description("This is an example widget.") // Description in widget gallery
    }
}

struct Widget1_Previews: PreviewProvider {
    static var previews: some View {
        Widget1EntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
