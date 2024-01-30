//
//  SkyTitle.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/7/23.
//

import SwiftUI

struct SkyTitle: View {
    
    let title: String
    var isCurrent: Bool = false
    var timezone: TimeZone? = nil
    
    var font: Font? = .title3
    var weight: Font.Weight = .bold
    var alignment: HorizontalAlignment = .leading
    
    
    var label: String {
        isCurrent ? "My Location" : title
    }
    
    var detail: String? {
        if let timezone  {
            let time = Date.now.time(timezone)
            return isCurrent ? title : time
        } else {return nil}
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: 0){
            Text(label)
            .font(font)
            .fontWeight(weight)
            if let detail {
                Text( detail )
                    .font(.footnote.weight(.semibold))
            }
        }
    }
}

extension SkyTitle {
    init(sky: Sky) {
        self.title = sky.title
        self.isCurrent = sky.currentLocation
    }
}


#Preview {
    SkyTitle(title: "New York", timezone: .current)
}
