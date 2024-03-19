//
//  takeMeHomeWidget.swift
//  takeMeHomeWidget
//
//  Created by Cedric Hommann on 19.02.24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider
{
    func placeholder(in context: Context) -> RouteInformation
    {
        RouteInformation(date: Date(), route: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (RouteInformation) -> ())
    {
        let entry = RouteInformation(date: Date(), route: [])
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ())
    {
        var entries: [RouteInformation] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5
        {
            // let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = RouteInformation(date: Date(timeIntervalSince1970: 1708526700),
                                         route:
                                            [
                                                RoutePart(vehicle: VehicleType.tram,
                                                          lineName: "3",
                                                          lineDestination: "Friedrich Engels Straße",
                                                          entrance: "DHGE",
                                                          entranceTime: Date(timeIntervalSince1970: 1708523280),
                                                          exit: "Friedrich Engels Straße",
                                                          exitTime: Date(timeIntervalSince1970: 1708524000)),
                                                RoutePart(vehicle: VehicleType.walk,
                                                          lineName: "",
                                                          lineDestination: "",
                                                          entrance: "Friedrich Engels Straße",
                                                          entranceTime: Date(timeIntervalSince1970: 1708524000),
                                                          exit: "Gera Hbf",
                                                          exitTime: Date(timeIntervalSince1970: 1708524300)),
                                                RoutePart(vehicle: VehicleType.train,
                                                          lineName: "RE1",
                                                          lineDestination: "Göttingen",
                                                          entrance: "Gera Hbf",
                                                          entranceTime: Date(timeIntervalSince1970: 1708524300),
                                                          exit: "Erfurt Hbf",
                                                          exitTime: Date(timeIntervalSince1970: 1708526700)),
                                                RoutePart(vehicle: VehicleType.tram,
                                                          lineName: "5",
                                                          lineDestination: "Zoopark",
                                                          entrance: "Erfurt Hbf",
                                                          entranceTime: Date(timeIntervalSince1970: 1708526700),
                                                          exit: "Lutherkirche",
                                                          exitTime: Date(timeIntervalSince1970: 1708527300)),
                                                RoutePart(vehicle: VehicleType.walk,
                                                          lineName: "",
                                                          lineDestination: "",
                                                          entrance: "Lutherkirche",
                                                          entranceTime: Date(timeIntervalSince1970: 1708527300),
                                                          exit: "Schobersmühlenweg",
                                                          exitTime: Date(timeIntervalSince1970: 1708527600)),
                                            ])
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct takeMeHomeWidgetEntryView : View
{
    var routeInformation: RouteInformation?
    
    var body: some View
    {
        if (routeInformation != nil)
        {
            HStack
            {
                TimelineView(from: routeInformation?.route.first?.entranceTime ?? .now,
                         to: routeInformation?.route.last?.exitTime ?? .now,
                             actual: routeInformation?.date ?? .now)
                Spacer()
                RouteView(routeInformation: routeInformation!)
                Spacer()
            }
        }
        else
        {
            Text("No Route")
        }
    }
}

struct takeMeHomeWidget: Widget
{
    let kind: String = "takeMeHomeWidgetDevWidget"

    var body: some WidgetConfiguration
    {
        StaticConfiguration(kind: kind, provider: Provider())
        { entry in
            if #available(iOS 17.0, *)
            {
                takeMeHomeWidgetEntryView(routeInformation: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            }
            else
            {
                takeMeHomeWidgetEntryView(routeInformation: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Route View")
        .description("This widget is showing your route.")
        .supportedFamilies([.systemLarge])
    }
}

#Preview(as: .systemSmall)
{
    takeMeHomeWidget()
}
timeline:
{
    RouteInformation(date: Date(timeIntervalSince1970: 1708524000),
                     route:
                        [
                            RoutePart(vehicle: VehicleType.tram,
                                      lineName: "3",
                                      lineDestination: "Friedrich Engels Straße",
                                      entrance: "DHGE",
                                      entranceTime: Date(timeIntervalSince1970: 1708523280),
                                      exit: "Friedrich Engels Straße",
                                      exitTime: Date(timeIntervalSince1970: 1708524000)),
                            RoutePart(vehicle: VehicleType.walk,
                                      lineName: "",
                                      lineDestination: "",
                                      entrance: "Friedrich Engels Straße",
                                      entranceTime: Date(timeIntervalSince1970: 1708524000),
                                      exit: "Gera Hbf",
                                      exitTime: Date(timeIntervalSince1970: 1708524300)),
                            RoutePart(vehicle: VehicleType.train,
                                      lineName: "RE1",
                                      lineDestination: "Göttingen",
                                      entrance: "Gera Hbf",
                                      entranceTime: Date(timeIntervalSince1970: 1708524300),
                                      exit: "Erfurt Hbf",
                                      exitTime: Date(timeIntervalSince1970: 1708526700)),
                            RoutePart(vehicle: VehicleType.tram,
                                      lineName: "5",
                                      lineDestination: "Zoopark",
                                      entrance: "Erfurt Hbf",
                                      entranceTime: Date(timeIntervalSince1970: 1708526700),
                                      exit: "Lutherkirche",
                                      exitTime: Date(timeIntervalSince1970: 1708527300)),
                            RoutePart(vehicle: VehicleType.walk,
                                      lineName: "",
                                      lineDestination: "",
                                      entrance: "Lutherkirche",
                                      entranceTime: Date(timeIntervalSince1970: 1708527300),
                                      exit: "Schobersmühlenweg",
                                      exitTime: Date(timeIntervalSince1970: 1708527600)),
                        ]
    )
}
