//
//  ItemViewMedium.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import SwiftUI

struct MediumView<G:View>: View {

    let label: String
    var detail: String? = nil
    
    @ViewBuilder
    var glyph: G
    

    var body: some View {
        HStack {
            glyph
                .frame(width: 70, height: 70)
            Spacer()
            VStack {
                Text(label)
                Text(detail ?? "--")
            }
        }
    }
}

#Preview {
    MediumView(label: "Label", detail: "Detail Label"){
        Image(systemName: "moon.stars")
    }
}
