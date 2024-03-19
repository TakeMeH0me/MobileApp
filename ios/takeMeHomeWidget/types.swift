//
//  types.swift
//  takeMeHomeWidgetDevWidgetExtension
//
//  Created by Cedric Hommann on 23.02.24.
//

import Foundation
import WidgetKit

struct RouteInformation: TimelineEntry
{
    let date: Date
    let route: [RoutePart]
}

struct RoutePart
{
    let vehicle: VehicleType
    let lineName: String
    let lineDestination: String
    let entrance: String
    let entranceTime: Date
    let exit: String
    let exitTime: Date
}

enum VehicleType
{
  case unknown
  case walk
  case tram
  case train
  case bus
}
