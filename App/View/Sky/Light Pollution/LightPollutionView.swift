//
//  LightPollutionView.swift
//  SkyAbove
//
//  Created by Michael Wilkowski on 1/17/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct LightPollutionView: View {
    @State var location: CLLocation
    var height: CGFloat = 250

    @State private var showMap = false

    var body: some View {
        VStack {
            LightPollutionMap(location: location)
                .frame(height: height)
                .cornerRadius(8)
        }
        .onTapGesture { showMap = true }
        .fullScreenCover(isPresented: $showMap) { sheet }
    }
    var sheet: some View {
        ZStack(alignment: .topLeading) {
            LightPollutionMap(location: location, userIteractions: true)
                .ignoresSafeArea(edges: .bottom)
            MapButtonsOverlay(showMap: $showMap, location: $location)
        }
    }
}



#Preview {
    LightPollutionView(location: MockData.locationNY)
}
    
