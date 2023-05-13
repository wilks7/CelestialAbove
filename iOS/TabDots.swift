//
//  TabDots.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI

struct TabDots: View {
    let skies: [Sky]
    let selected: Sky?
    
    func color(for sky: Sky) -> Color {
        if sky == selected {
            return .white
        } else {
            return Color.white.opacity(0.5)
        }
    }
    
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(skies, id: \.self) { sky in
                let color: Color = color(for: sky)

                if sky.currentLocation {
                    Image(systemName: "location.fill")
                        .font(.caption2)
                        .offset(y: 0)
                        .foregroundColor(color)
                } else {
                    Circle().fill(color)
                        .frame(width: 7, height: 7)
                }
            }
        }
    }
}

struct TabDots_Previews: PreviewProvider {
    static var previews: some View {
        TabDots(skies: skies, selected: sky)
    }
}
