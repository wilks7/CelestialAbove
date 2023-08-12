//
//  SkyView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI

struct SkyView: View {
    @EnvironmentObject var navigation: NavigationManager
    let sky: Sky
        
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                header
                ForEach(sky.events) { events in
                    SkyItemView(events, .medium)
                }
                if let weather = sky.weather {
                    WeatherCells(weather)
                }
            }
            .padding(.horizontal)
        }
        .scrollContentBackground(.hidden)
        .navigationTitle(sky.title ?? "Title")

    }
    
    var header: some View {
        VStack {
            HStack {
                Spacer()
                Text("90%")
                    .font(.system(size: 82))
                Spacer()
            }
        }
    }
    

}

#Preview {
    ModelPreview {
        SkyView(sky: $0)
    }
}
