//
//  ItemView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import WeatherKit

enum ViewType { case detail, chart }

struct SkyGridRow<Cell:View, Chart:View, Sheet:View>: View {
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
    
    private var hasSheet: Bool {
        !(Sheet.self is EmptyView.Type)
    }

    var body: some View {
        VStack(alignment: .leading) {
            ItemHeader(title: title, symbolName: symbolName)
            if viewType == .chart, hasChart {
                chart
            } else {
                cell
                    .padding(4)
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
                        if hasSheet {
                            showSheet = true
                        }
                    }
                )
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

extension SkyGridRow {
    
    init(title: String, symbolName: String, @ViewBuilder cell: () -> Cell, @ViewBuilder sheet: () -> Sheet) where Chart == EmptyView {
        self.title = title
        self.symbolName = symbolName
        self.cell = cell()
        self.sheet = sheet()
        self.chart = EmptyView()
    }
    
    init(title: String, symbolName: String, @ViewBuilder cell: () -> Cell) where Chart == EmptyView, Sheet == EmptyView {
        self.title = title
        self.symbolName = symbolName
        self.cell = cell()
        self.sheet = EmptyView()
        self.chart = EmptyView()
    }
}

import CoreLocation
extension SkyGridRow {

    
    init<W:WeatherItem>( _ data: W.Type = W.self, weather: Weather) where Cell == ItemSmall<W.Glyph>, Chart == WeatherChartView<W>, Sheet == Text {
        let item = W(weather: weather)
        self.init(title: W.title, symbolName: item.symbolName) {
            ItemSmall(label: item.label, detail: item.detail, glyph: item.glyph)
        } chart: {
            WeatherChartView(item: item)
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

