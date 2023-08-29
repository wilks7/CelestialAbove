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
        SkyGridCell(title: "Light Pollution", symbolName: "map"){
            VStack {
                LightPollutionMap(location: location)
                    .frame(height: height)
                    .cornerRadius(8)
            }
            .padding(8)
        } chart: {
            EmptyView()
        } sheet: {
            ZStack(alignment: .topLeading) {
                LightPollutionMap(location: location, userIteractions: true)
                    .ignoresSafeArea(edges: .bottom)
                MapButtonsOverlay(location: $location)
            }
        }
        

    }
}



#Preview {
    LightPollutionCell(location: MockData.locationNY)
}
    
