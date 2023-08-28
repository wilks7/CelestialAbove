//
//  ItemView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import WeatherKit

enum ViewType { case detail, chart }

struct SkyGridCell<D:View, C:View>: View {
    let title: String
    let symbolName: String
    @State var viewType: ViewType = .detail

    @ViewBuilder
    var detail: D
    
    @ViewBuilder
    var chart: C
    
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
                detail
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
            Text("Hi")
        }
        .transparent()
    }
}

extension SkyGridCell {
    
    init<I:WeatherItem>(_ type: I.Type, hour: HourWeather, _ hourly: [HourWeather], day: DayWeather?)
        where D == SmallView<I.Constant>, 
            C == ItemChart<I.Data> {
            
        let item = I(hour: hour, hourly, day: day)
        self.title = item.title
        self.symbolName = item.symbolName
        self.detail = SmallView(item: item)
                self.chart = ItemChart<I.Data>(chartPoints: item.chartData, now: .init(reference: .now, value: item.value))
        self.viewType = .detail

    }
}
