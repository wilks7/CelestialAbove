//
//  StatusTitle.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/7/23.
//

import SwiftUI

struct StatusTitle: View {
    let title: String
    let timezone: TimeZone
    
    var currentLocation: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            SkyTitle(title: title, isCurrent: currentLocation)
            if timezone != Calendar.current.timeZone {
                Text( Date.now.time(timezone) )
                    .font(.caption2.weight(.semibold))
            }
        }
    }
}

#Preview {
    StatusTitle(title: "New York", timezone: TimeZone(identifier: "America/NewYork")!)
}
