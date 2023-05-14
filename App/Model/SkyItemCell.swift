//
//  SkyItemCell.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import WeatherKit


struct SkyItemCell<I:SkyItem>: SkyItemView {
    let item: I
    
    init(_ item: I){
        self.item = item
    }
    
    init(_ weather: Weather) where I: WeatherItem {
        self.item = I(weather)
    }
    
    @State private var showDetail = false
    
    var body: some View  {
        Group {
            switch item {
            case is any WeatherItem: compact
            default: medium.layoutPriority(1) // Take up the entire row

                
            }
        }
//        compact
//            .sheet(isPresented: $showDetail) {
//                full
//                    .presentationDetents([.large,.medium])
//            }
    }
    


    @ViewBuilder
    var compact: some View {
        VStack(alignment: .leading, spacing: 10) {
            ItemHeader(title: item.title, symbolName: item.symbolName)
            Text(item.label ?? "--")
                .font(.title2)
                .fontWeight(.semibold)
            Text(item.subtitle ?? "--")
                .font(.headline)
        }
        .frame(maxWidth: .infinity, minHeight: 164, alignment: .leading)
        .padding(.horizontal)
//            .transparent()
    }
    
    
    @ViewBuilder
    var medium: some View {
        HStack {
            Spacer()
            ChartView(data: item.data, time: .constant(.now))
        }
    }
    
    var full: some View {
        ZStack{}
    }
}

struct SkyItemCell_Previews: PreviewProvider {
    static var previews: some View {
        SkyItemCell(event)
    }
}
