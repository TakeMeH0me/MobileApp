//
//  types.swift
//  takeMeHomeWidgetDevWidgetExtension
//
//  Created by Cedric Hommann on 23.02.24.
//

import Foundation
import WidgetKit

struct RouteInformation: TimelineEntry, Codable
{
    let date: Date
    let route: [RoutePart]
    
    static func fromJson(jsonString: String) -> RouteInformation?
    {
        var jsonData = jsonString.data(using: .utf8)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let routeInformation = try decoder.decode(RouteInformation.self, from: jsonData!)
            print(routeInformation)
            return routeInformation
        } catch {
            print(error)
        }
        
        return nil
    }
}

struct RoutePart: Codable
{
    let vehicle: VehicleType
    let lineName: String
    let lineDestination: String
    let entrance: String
    let entranceTime: Date
    let exit: String
    let exitTime: Date
    
    static func fromJson(jsonString: String) -> RoutePart?
    {
        var jsonData = jsonString.data(using: .utf8)
            
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let routePart = try decoder.decode(RoutePart.self, from: jsonData!)
            print(routePart)
            return routePart
        } catch {
            print(error)
        }
        
        return nil
    }
}

enum VehicleType: String, Codable
{
  case unknown = "unknown"
  case walk = "walk"
  case tram = "tram"
  case train = "train"
  case bus = "bus"
}
