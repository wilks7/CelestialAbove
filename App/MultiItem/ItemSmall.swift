//
//  ItemCell.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/1/23.
//

import SwiftUI

struct ItemSmall<G:View, D:View>: View {
    let label: String
    
    
    @ViewBuilder
    let glyph: G
    
    @ViewBuilder
    let detail: D

    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            glyph
            detail

        }
    }
}

extension ItemSmall {
    init(label: String, detail: String? = nil, @ViewBuilder glyph: () -> G ) where D == Text {
        self.label = label
        self.detail = Text(detail ?? "")
        self.glyph = glyph()
    }
    
    init<I:Item>(item: I) where G == I.Glyph, I:Labelable, D == Text {
        self.label = item.label
        self.glyph = item.glyph
        let detail = (item as? Detailable)?.detail
        self.detail = Text(detail ?? "")
    }
}

#Preview {
    ItemSmall(label: "Label", detail: "Detail") {
        Image(systemName: "cloud")
            .font(.system(size: 64))
    }
}
