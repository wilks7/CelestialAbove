//
//  HYGStarDetailsView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 9/13/23.
//

import SwiftUI
import CoreLocation

struct HYGStarDetailsView: View {
    let star: HYGStar
    let location: CLLocation
    var body: some View {
        VStack {
            Text(star.name)
                .font(.title)
            Text("Star")
                .font(.headline)
            Grid {
                GridRow {
                    Text("HD")
                    Text((star.hd ?? 0).description)
                }
                GridRow {
                    Text("HIP")
                    Text((star.hip ?? 0).description)
                }
                GridRow {
                    Text("HYG")
                    Text(star.id.description)
                }
            }
            Grid {
                GridRow {
                    Text("Parsecs")
                    Text((star.dist ?? 0).description)
                }
                GridRow {
                    Text("Magnitude")
                    Text(star.mag.description)
                }
                GridRow {
                    Text("Constellation")
                    Text(star.con ?? "")
                }

            }
        }
    }
}

//#Preview {
//    HYGStarDetailsView()
//}
