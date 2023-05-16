//
//  ItemViewMedium.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import SwiftUI

struct ItemViewMedium<I:Item>: View {
    enum ViewType { case detail, chart }

    let item: I
    @State var type: ViewType = .chart

    var body: some View {
        Group {
            if type == .detail {
                HStack {
                    item.constant
                    Spacer()
                    VStack {
                        Text(item.label ?? "--")
                        Text(item.subtitle ?? "--")
                    }
                }
            } else {
                Text("Charts")
            }
        }
        .onTapGesture {
            withAnimation {
                self.type = self.type == .detail ? .chart : .detail
            }
        }
    }
}

struct ItemViewMedium_Previews: PreviewProvider {
    static var previews: some View {
        ItemViewMedium(item: event)
    }
}
