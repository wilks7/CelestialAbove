//
//  ItemView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import WeatherKit

enum ViewType { case detail, chart }

struct SkyGridCell<Cell:View, C:View, S:View>: View {
    let title: String
    let symbolName: String

    @State var viewType: ViewType = .detail
    
    @ViewBuilder
    var cell: Cell
    
    @ViewBuilder
    var chart: C
    
    @ViewBuilder
    var sheet: S
        
    @State private var showSheet = false
    
    private var hasChart: Bool {
        !(C.self is EmptyView.Type)
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
}

extension SkyGridCell {
    init<W:WeatherItem>( _ data: W.Type = W.self, weather: Weather) where Cell == W.Small, C == W.Chart, S == SkyItemDetailView<W> {
        let item = W(weather: weather)
        self.init(item: item) {item.small}

    }
    
    init(event: CelestialEvents) where Cell == CelestialEvents.Medium, C == CelestialEvents.Chart, S == SkyItemDetailView<CelestialEvents> {
        self.init(item: event) { event.medium }
        self._viewType = State(initialValue: .chart)
    }
    
    init<I:SkyItem>(item: I, @ViewBuilder cell: ()->Cell) where C == I.Chart, S == SkyItemDetailView<I> {
        self.title = item.symbolName.capitalized
        self.symbolName = item.symbolName
        self.chart = item.chart
        self.cell = cell()
        self.sheet = SkyItemDetailView(item: item)
    }
}


