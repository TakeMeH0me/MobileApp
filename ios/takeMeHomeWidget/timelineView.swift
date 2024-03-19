//
//  timeLineView.swift
//  takeMeHomeWidgetDevWidgetExtension
//
//  Created by Cedric Hommann on 23.02.24.
//

import Foundation
import SwiftUI

struct TimelineView : View
{
    let from: Date
    let to: Date
    let actual: Date
    
    var body: some View
    {
        let percent: Double = (from.distance(to: actual) / from.distance(to: to)) * 100
        
        VStack
        {
            Spacer()
            Text(from.formatted(.dateTime.hour().minute())).bold()
            Image(systemName: percent > 0.0 ? "circle.fill" : "circle").resizable().frame(width: 8, height: 8)
            Image(systemName: percent > 6.7 ? "circle.fill" : "circle").resizable().frame(width: 8, height: 8)
            Image(systemName: percent > 13.4 ? "circle.fill" : "circle").resizable().frame(width: 8, height: 8)
            Image(systemName: percent > 20.1 ? "circle.fill" : "circle").resizable().frame(width: 8, height: 8)
            Image(systemName: percent > 26.8 ? "circle.fill" : "circle").resizable().frame(width: 8, height: 8)
            Image(systemName: percent > 33.5 ? "circle.fill" : "circle").resizable().frame(width: 8, height: 8)
            Image(systemName: percent > 40.2 ? "circle.fill" : "circle").resizable().frame(width: 8, height: 8)
            Image(systemName: percent > 46.9 ? "circle.fill" : "circle").resizable().frame(width: 8, height: 8)
            Image(systemName: percent > 53.6 ? "circle.fill" : "circle").resizable().frame(width: 8, height: 8)
            Image(systemName: percent > 60.3 ? "circle.fill" : "circle").resizable().frame(width: 8, height: 8)
            Image(systemName: percent > 67.0 ? "circle.fill" : "circle").resizable().frame(width: 8, height: 8)
            Image(systemName: percent > 73.7 ? "circle.fill" : "circle").resizable().frame(width: 8, height: 8)
            Image(systemName: percent > 80.4 ? "circle.fill" : "circle").resizable().frame(width: 8, height: 8)
            Image(systemName: percent > 87.1 ? "circle.fill" : "circle").resizable().frame(width: 8, height: 8)
            Image(systemName: percent > 93.8 ? "circle.fill" : "circle")
                .resizable().frame(width: 8, height: 8).padding(.bottom, 4)
            Image(systemName: "arrowshape.down.fill").padding(.bottom, 2)
            Text(to.formatted(.dateTime.hour().minute())).bold()
            Spacer()
        }
    }
}
