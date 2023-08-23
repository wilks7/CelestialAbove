//
//  ItemSmallView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import SwiftUI

struct SmallView<I:SkyItem>: View {
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
                    item.constant
                        .frame(width: 70, height: 70)
                    Text(item.subtitle ?? "--")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            } else {
                ItemChartView(item: item)
            }
        }
        .onTapGesture {
            withAnimation{
                self.type = self.type == .detail ? .chart : .detail
            }
        }
    }
}

#Preview {
    SmallView(item: MockData.mars)
}

