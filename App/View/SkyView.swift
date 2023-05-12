//
//  SkyView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI

struct SkyView: View {
    @ObservedObject var sky: Sky
    
    var body: some View {
        ScrollView {
            VStack {
                Text(sky.title)
                Button("Green"){
                    sky.color = .green
                }
            }
            .background(sky.color)
        }
    }
}

struct SkyView_Previews: PreviewProvider {
    static var previews: some View {
        SkyView(sky: NY)
    }
}
