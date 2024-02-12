//
//  ItemCompact.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/4/23.
//

import SwiftUI

public struct ItemCompact<Top:View, Bottom: View>: View {
    let alignment: HorizontalAlignment

    let top: Top
    let bottom: Bottom
        
    public var body: some View {
        VStack(alignment: alignment) {
            top
            bottom
        }
    }
}

public extension ItemCompact {
    
    init(top: Top, bottom: Bottom, alignment: HorizontalAlignment = .leading){
        self.top = top
        self.bottom = bottom
        self.alignment = alignment
    }
    
    init(alignment: HorizontalAlignment = .leading, label: String, sublabel: String? = nil) where Top == Text, Bottom == Text {
        self.alignment = alignment
        self.top = Text(label)
        self.bottom = Text(sublabel ?? "")
    }
    
    init(alignment: HorizontalAlignment = .leading, label: String?, @ViewBuilder glyph: () -> Top) where Bottom == Text {
        self.alignment = alignment
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
