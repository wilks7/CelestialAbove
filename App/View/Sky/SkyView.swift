//
//  SkyView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI

struct SkyView: View {
    @EnvironmentObject var navigation: NavigationManager
    @ObservedObject var sky: Sky
        
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
        .environmentObject(sky)
        .scrollContentBackground(.hidden)
        .navigationTitle(sky.title)

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

struct SkyView_Previews: PreviewProvider {
    static var previews: some View {
        SkyView(sky: sky)
    }
}
