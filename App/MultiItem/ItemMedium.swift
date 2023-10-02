//
//  ItemMedium.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/1/23.
//

import SwiftUI

struct ItemMedium<Glyph: View>: View {
        
    let title: String
    var subtitle: String? = nil
    var detail: String? = nil
    var subdetail: String? = nil
    var label: String? = nil
    var sublabel: String? = nil
    
    @ViewBuilder
    var glyph: Glyph
    
    var body: some View {
        HStack {
            glyph
            Spacer()
            Grid {
                GridRow {
                    Text(title)
                    Text(subtitle ?? "--")
                }
                .gridCellAnchor(.leading)
                if let detail, let subdetail {
                    GridRow {
                        Text(detail)
                        Text(subdetail)
                    }
                    .gridCellAnchor(.leading)
                }
                if let label, let sublabel {
                    GridRow {
                        Text(label)
                        Text(sublabel)
                    }
                    .gridCellAnchor(.leading)
                }
            }
        }
    }
}

//#Preview {
//    ItemMedium()
//}
