//
//  routePartView.swift
//  takeMeHomeWidgetDevWidgetExtension
//
//  Created by Cedric Hommann on 27.02.24.
//

import Foundation
import SwiftUI

struct RoutePartView : View
{
    let routePart: RoutePart
    
    var body: some View
    {
        switch routePart.vehicle
        {
        case VehicleType.walk:
            HStack
            {
                Image(systemName: VehiceTypeToImageString(vehicle: routePart.vehicle))
                Image(systemName: "arrow.right")
                Text(routePart.exit).lineLimit(1)
            }
        default:
            VStack(alignment: .leading)
            {
                HStack
                {
                    Image(systemName: VehiceTypeToImageString(vehicle: routePart.vehicle))
                    Text("-")
                    Text(routePart.lineName).bold()
                    Text("-")
                    Text(routePart.lineDestination).lineLimit(1)
                }
                HStack
                {
                    Text(routePart.entrance).lineLimit(1)
                    Image(systemName: "arrow.right")
                    Text(routePart.exit).lineLimit(1)
                }
            }
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
