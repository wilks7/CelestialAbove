//
//  ItemCell.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/1/23.
//

import SwiftUI

struct ItemCell<G:View>: View {
    let label: String
    var detail: String? = nil
    let glyph: G
    
    var body: some View {
        small
    }
    
    var small: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            glyph
            if let detail {
                Text(detail)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }

        }
        .padding(.horizontal)
    }
}

extension ItemCell {
    init(label:String, detail: String? = nil, @ViewBuilder glyph: ()->G) {
        self.label = label
        self.detail = detail
        self.glyph = glyph()
    }
}

//#Preview {
//    ItemCell()
//}
