//
//  ItemCompact.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/4/23.
//

import SwiftUI

struct ItemCompact<Top:View, Bottom: View>: View {
    var alignment: HorizontalAlignment = .leading

    let top: Top
    let bottom: Bottom
    
    var body: some View {
        VStack(alignment: alignment) {
            top
            bottom
        }
    }
}

extension ItemCompact {
    init(alignment: HorizontalAlignment = .leading, label: String, sublabel: String? = nil) where Top == Text, Bottom == Text {
        self.top = Text(label)
        self.bottom = Text(sublabel ?? "")
    }
    
    init(alignment: HorizontalAlignment = .leading, label: String?, @ViewBuilder glyph: () -> Top) where Bottom == Text {
        self.top = glyph()
        self.bottom = Text(label ?? "")
    }
}


#Preview {
    ItemCompact(label: "Label", sublabel: "Sublabel")
}

#Preview {
    ItemCompact(label: "Label Text") {
        Image(systemName: "cloud")
            .font(.title)
    }
}
