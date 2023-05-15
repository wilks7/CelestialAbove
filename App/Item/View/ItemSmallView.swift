//
//  ItemSmallView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import SwiftUI

struct ItemViewSmall<I:Item>: View {
    enum ViewType { case detail, chart }
    let item: I
    @State var type: ViewType = .detail
    
    var body: some View {
        Group {
            if type == .detail {
                VStack(alignment: .leading, spacing: 10) {
                    Text(item.label ?? "--")
                        .font(.title2)
                        .fontWeight(.semibold)
                    I.ValueView(item: item)
                    Text(item.subtitle ?? "--")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            } else {
                ItemChart(item: item)
            }
        }
        .onTapGesture {
            withAnimation{
                self.type = self.type == .detail ? .chart : .detail
            }
        }
    }
}

struct ItemSmallView_Previews: PreviewProvider {
    static var previews: some View {
        ItemViewSmall(item: event)
    }
}
