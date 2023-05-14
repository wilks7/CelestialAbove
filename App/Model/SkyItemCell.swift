//
//  SkyItemCell.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI

struct SkyItemCell<I:SkyItem>: SkyItemView {
    let item: I?
    
    init(_ item: I?) {
        self.item = item
    }
    
    @State private var showDetail = false
    
    var body: some View {
        compact
            .sheet(isPresented: $showDetail) {
                full
                    .presentationDetents([.large,.medium])
            }
    }
    
    @ViewBuilder
    var compact: some View {
        if let item {
            VStack(alignment: .leading, spacing: 10) {
                ItemHeader(title: item.title, symbolName: item.symbolName)
                Text(item.label ?? "--")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(item.subtitle ?? "--")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.horizontal)
//            .transparent()
        }
        ZStack{}
    }
    
    var medium: some View {
        ZStack{}
    }
    
    var full: some View {
        ZStack{}
    }
}

struct SkyItemCell_Previews: PreviewProvider {
    static var previews: some View {
        SkyItemCell(item: event)
    }
}
