//
//  takeMeHomeWidget.swift
//  takeMeHomeWidget
//
//  Created by Cedric Hommann on 19.02.24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> RouteInformation {
        RouteInformation(date: Date(), currentTime: Date(), route: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (RouteInformation) -> ()) {
        let entry = RouteInformation(date: Date(), currentTime: Date(), route: [])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [RouteInformation] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = RouteInformation(date: .now,
                                         currentTime: .now,
                                         route:
                                            [
                                                RoutePart(from: .now,
                                                          to: .now.addingTimeInterval(100000),
                                                          vehicle: Vehicle.train,
                                                          lineName: "RE3")
                                            ])
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct RouteInformation: TimelineEntry {
    let date: Date
    let currentTime: Date
    let route: [RoutePart]
}

struct RoutePart {
    let from: Date
    let to: Date
    let vehicle: Vehicle
    let lineName: String
}

enum Vehicle {
  case unknown
  case walk
  case train
  case bus
}


struct takeMeHomeWidgetEntryView : View {
    var routeInformation: Provider.Entry

    var body: some View {
        HStack {
            VStack
            {
                Text((routeInformation.route.first?.from ?? Date.now).formatted(.dateTime.hour().minute())).bold()
                Spacer()
                Image(systemName: "arrowshape.down.fill")
                Spacer()
                Text((routeInformation.route.last?.to ?? Date.now).formatted(.dateTime.hour().minute())).bold()
            }
            Spacer()
        }
    }
}

struct takeMeHomeWidget: Widget {
    let kind: String = "takeMeHomeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                takeMeHomeWidgetEntryView(routeInformation: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                takeMeHomeWidgetEntryView(routeInformation: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    takeMeHomeWidget()
} timeline: {
    RouteInformation(date: .now,
                     currentTime: .now,
                     route: 
                        [
                            RoutePart(from: .now,
                                      to: .now.addingTimeInterval(100000),
                                      vehicle: Vehicle.train,
                                      lineName: "RE3")
                        ]
    )
}
