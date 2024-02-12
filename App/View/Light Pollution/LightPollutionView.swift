//
//  LightPollutionView.swift
//  SkyAbove
//
//  Created by Michael Wilkowski on 1/17/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct LightPollutionCell: View {
    @State var location: CLLocation
    var height: CGFloat = 250

    var body: some View {
        SkyGridRow(title: "Light Pollution", symbolName: "map"){
            VStack {
//                #if os(macOS)
                
//                #else
                LightPollutionMap(location: location)
                    .frame(height: height)
                    .cornerRadius(8)
//                #endif
            }
            .padding(8)
        } sheet: {

            
            ZStack(alignment: .topLeading) {
//                #if os(macOS)

//                #else
                LightPollutionMap(location: location, userIteractions: true)
                    .ignoresSafeArea(edges: .bottom)
//                #endif

                MapButtonsOverlay(location: $location)
            }
        }
        

    }
}



#Preview {
    LightPollutionCell(location: MockData.locationNY)
}
    
