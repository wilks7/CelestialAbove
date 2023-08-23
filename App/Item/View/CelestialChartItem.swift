//
//  CelestialChartItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/22/23.
//

import SwiftUI

struct CelestialChartItem: View {
    let event: CelestialEvents
    var sunrise: Date
    var sunset: Date
    
    enum ViewType { case detail, chart }
    @State var type: ViewType = .chart
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            ItemHeader(title: event.title, symbolName: event.symbolName)
                .onTapGesture(perform: showDetail)
            chart
        }
        .padding(8)
        .sheet(isPresented: $showSheet) {
            VStack{
                Spacer()
                Text("Hi")
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .transparent()

    }

    @ViewBuilder
    var chart: some View {
        Group {
            if type == .detail {
                HStack {
                    event.constant
                        .frame(width: 70, height: 70)
                    Spacer()
                    VStack {
                        Text(event.label ?? "--")
                        Text(event.subtitle ?? "--")
                        Text(event.detail ?? "--")
                    }
                }
            }
            else {
                CelestialChart(events: event, sunrise: sunrise, sunset: sunset)
            }
        }
        .onTapGesture {
            withAnimation {
                self.type = self.type == .detail ? .chart : .detail
            }
        }
    }
    
    private func showDetail() {
        self.showSheet = true
    }
}

#Preview {
    let sunrise = Date.now.startOfDay().addingTimeInterval(60*60*7)
    let sunset = Date.now.endOfDay().addingTimeInterval(-60*60*7)
    return CelestialChartItem(event: MockData.mars, sunrise: sunrise, sunset: sunset)
}
