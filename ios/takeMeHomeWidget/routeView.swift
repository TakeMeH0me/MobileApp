//
//  routeView.swift
//  takeMeHomeWidgetDevWidgetExtension
//
//  Created by Cedric Hommann on 23.02.24.
//

import Foundation
import SwiftUI

struct RouteView : View
{
    let routeInformation: RouteInformation
    var routePart: RoutePart?
    {
        routeInformation.route.first(where: { $0.entranceTime <= routeInformation.date && $0.exitTime >= routeInformation.date })
    }
    var nextRoutePart: RoutePart?
    {
        if (routePart == nil)
        {
            if (routeInformation.route.isEmpty)
            {
                return nil
            }
            else
            {
                return routeInformation.route[0]
            }
        }
        
        var beforeIndex: Int?
        {
            routeInformation.route.firstIndex(where: { $0.entranceTime <= routeInformation.date && $0.exitTime >= routeInformation.date })
        }
        
        return beforeIndex != nil && routeInformation.route.count > beforeIndex! + 1 ? routeInformation.route[beforeIndex! + 1] : nil
    }
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            Spacer()
            
            if (routePart == nil)
            {
                Text("Start")
                Spacer()
                HStack
                {
                    Image(systemName: "arrowshape.down.fill")
                    Text(nextRoutePart?.entranceTime.formatted(.dateTime.hour().minute()) ?? "")
                }
                Spacer()
                nextRoutePart != nil ? RoutePartView(routePart: nextRoutePart!) : nil
            }
            else if (nextRoutePart == nil)
            {
                routePart != nil ? RoutePartView(routePart: routePart!) : nil
                Spacer()
                HStack
                {
                    Image(systemName: "arrowshape.down.fill")
                    Text(routePart?.entranceTime.formatted(.dateTime.hour().minute()) ?? "")
                }
                Spacer()
                Text("Destination")
            }
            else
            {
                HStack
                {
                    Image(systemName: "arrowshape.down.fill")
                    Text(routePart?.entranceTime.formatted(.dateTime.hour().minute()) ?? "")
                }
                Spacer()
                routePart != nil ? RoutePartView(routePart: routePart!) : nil
                Spacer()
                HStack
                {
                    Image(systemName: "arrowshape.down.fill")
                    VStack
                    {
                        Text(routePart?.exitTime.formatted(.dateTime.hour().minute()) ?? "")
                        Text(nextRoutePart?.entranceTime.formatted(.dateTime.hour().minute()) ?? "")
                    }
                }
                Spacer()
                nextRoutePart != nil ? RoutePartView(routePart: nextRoutePart!) : nil
                Spacer()
                HStack
                {
                    Image(systemName: "arrowshape.down.fill")
                    Text(nextRoutePart?.exitTime.formatted(.dateTime.hour().minute()) ?? "")
                }
            }
            
            Spacer()
        }
    }
    
    private func VehiceTypeToImageString(vehicle: VehicleType) -> String
    {
        switch vehicle {
        case VehicleType.walk:
            return "figure.walk"
        case .tram:
            return "tram.fill"
        case .train:
            return "lightrail.fill"
        case .bus:
            return "bus.fill"
        case .unknown:
            return "questionmark"
        }
    }
}
