//
//  ItemMedium.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/1/23.
//

import SwiftUI

public struct ItemMedium<Glyph: View>: View {
        
    var title: String? = nil
    var subtitle: String? = nil
    
    var label: String
    var sublabel: String? = nil
    
    var detail: String? = nil
    var subdetail: String? = nil

    var info: String? = nil
    var subinfo: String? = nil
    
    
    var glyphSize: CGFloat = 120
    
    let opacity: CGFloat = 0.7

    @ViewBuilder
    var glyph: Glyph
    
    
    public var body: some View {
        HStack {
            Grid(verticalSpacing: 8) {
                GridRow {
                    Text(label)
                        .font(.headline)
                        .gridCellAnchor(.leading)
                    Spacer()
                    Text(sublabel ?? "--")
                        .gridCellAnchor(.trailing)
                        .opacity(opacity)

                }
                Divider()
                if let detail, let subdetail {
                    GridRow {
                        Text(detail)
                            .font(.headline)
                            .gridCellAnchor(.leading)
                        Spacer()
                        Text(subdetail)
                            .gridCellAnchor(.trailing)
                            .opacity(opacity)
                    }
                }
                Divider()

                if let info, let subinfo {
                    GridRow {
                        Text(info)
                            .gridCellAnchor(.leading)
                            .font(.headline)
                        Spacer()
                        Text(subinfo)
                            .gridCellAnchor(.trailing)
                            .opacity(opacity)
                    }
                }
                
            }
            .frame(height: 100)
            .padding(.trailing)
            glyph
                .frame(width: glyphSize, height: glyphSize)
        }
        .frame(maxHeight: 148)
    }
}

public extension ItemMedium {
    init<I:Item>(item: I) where Glyph == I.Glyph, I:Labelable {
        self.glyph = item.glyph

        self.title = item.title
        self.subtitle = item.subtitle
        
        self.label = item.label
        self.sublabel = item.sublabel
        
        if let item = item as? Detailable {
            self.detail = item.detail
            self.subdetail = item.subdetail
            
            self.info = item.info
            self.subinfo = item.subinfo
        }
    }
}

#Preview {
    ItemMedium(
        title: "Title", subtitle: "sub title",
        label: "Label", sublabel: "sub label",
        detail: "Detail", subdetail: "sub detail",
        info: "Info", subinfo: "sub info",
        glyphSize: 120) {
            Image(systemName: "cloud")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding()
        .background(Color.indigo)
        .clipShape(RoundedRectangle(cornerRadius: 16))
}
