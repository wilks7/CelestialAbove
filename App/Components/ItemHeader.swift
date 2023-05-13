//
//  ItemHeader.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI

struct ItemHeader: View {
    let title: String
    let symbolName: String
    var font: Font = .footnote.weight(.semibold)
    
    var body: some View {
        if !isWidget {
            HStack {
                Image(systemName: symbolName)
                Text(title)
                Spacer()
            }
            .font(font)
        }
    }
}

struct ItemHeader_Previews: PreviewProvider {
    static var previews: some View {
        ItemHeader(title: "Clouds", symbolName: "cloud")
    }
}
