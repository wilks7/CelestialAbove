//
//  ItemView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import WeatherKit

enum ViewType { case detail, chart }

struct SkyGridCell<Cell:View, Chart:View, Sheet:View>: View {
    let title: String
    let symbolName: String

    @State var viewType: ViewType = .detail
    
    @ViewBuilder
    var cell: Cell
    
    @ViewBuilder
    var chart: Chart
    
    @ViewBuilder
    var sheet: Sheet
        
    @State private var showSheet = false
    
    private var hasChart: Bool {
        !(Chart.self is EmptyView.Type)
    }

    var body: some View {
        VStack {
            ItemHeader(title: title, symbolName: symbolName)
            if viewType == .chart, hasChart {
                chart
            } else {
                cell
            }
        }
        .gesture(
            TapGesture(count: 2)
                .onEnded { _ in
                    if hasChart {
                        withAnimation {
                            self.viewType = viewType == .detail ? .chart : .detail
                        }
                    }
                }
                .exclusively(before: TapGesture(count: 1)
                    .onEnded { _ in
                        showSheet = true
                    })
        )

        .padding(8)
        .sheet(isPresented: $showSheet) {
            sheet
        }
        .transparent()
    }
    
    struct ItemHeader: View {
        let title: String
        let symbolName: String
        var font: Font = .footnote.weight(.semibold)
        
        var body: some View {
            if !isWidget {
                HStack {
                    Image(systemName: symbolName)
                    Text(title)
                    Spacer()
                }
                .font(font)
            }
        }
    }
}

extension SkyGridCell {
    init<W:WeatherItem>( _ data: W.Type = W.self, weather: Weather) where Cell == Text, Chart == ItemChart, Sheet == Text {
        let item = W(weather: weather)
        self.init(title: item.symbolName, symbolName: item.symbolName) {
            Text(item.symbolName)
        } chart: {
            ItemChart()
        } sheet: {
            Text("Sheet")
        }
        
    }
}
//
//    
//    init<I:SkyItem>(item: I, @ViewBuilder cell: ()->Cell) where C == I.Chart, S == SkyItemDetailView<I> {
//        self.title = item.symbolName.capitalized
//        self.symbolName = item.symbolName
//        self.chart = item.chart
//        self.cell = cell()
//        self.sheet = SkyItemDetailView(item: item)
//    }
//}
//

