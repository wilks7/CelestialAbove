//
//  SkyItemChart.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/27/23.
//

import SwiftUI
import Charts

struct ItemChart<C:ChartData>: View {
    typealias PointFor = (C.X) -> C.Y

    var chartPoints: [C]
    var now: C? = nil
    var showZero = false
    var pointFor: PointFor? = nil
    
    @State var selected: (reference:C.X, value:C.Y)?

    var body: some View {
        Chart {
            ForEach(chartPoints){
                LineMark(
                    x: .value("Time", $0.reference),
                    y: .value("Value", $0.value)
                )
                .lineStyle(.init(lineWidth: 4))
            }
            if showZero {
                RuleMark(y: .value("Value", 0))
                    .foregroundStyle(.white)
            }
            if let selected {
                RuleMark(x: .value("Time", selected.reference))
                    .foregroundStyle(.gray)
                    .annotation(position: .overlay) {
                        if let date = selected.reference as? Date {
                            Text(date.time())
                                .font(.caption)
                        }
                    }
                PointMark(
                    x: .value("Time", selected.reference),
                    y: .value("Value", selected.value)
                )
                .foregroundStyle(.white)
            } else if let now {
                PointMark(
                    x: .value("Time", now.reference),
                    y: .value("Value", now.value)
                )
                .foregroundStyle(.white)
            }
        }
        .chartOverlay { proxy in
            GeometryReader { geometry in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                selectedValue(proxy: proxy, geometry: geometry, value: value)
                            }
                            .onEnded{ _ in
                                self.selected = nil
                            }
                    )
            }
        }
    }
    
    private func selectedValue(proxy: ChartProxy, geometry: GeometryProxy, value: DragGesture.Value) {
        guard let plotFrame = proxy.plotFrame else {return}
        
        let origin = geometry[plotFrame].origin
        
        let location = CGPoint(
            x: value.location.x - origin.x,
            y: value.location.y - origin.y
        )
        let point = proxy.value(
            at: location,
            as: (C.X, C.Y).self
        )

        guard
            let reference = point?.0,
            let first = chartPoints.first?.reference,
            let last = chartPoints.last?.reference,
            reference >= first && reference <= last
        else {
            return
        }
        
        if let pointFor {
            self.selected = (reference, pointFor(reference))
        }
//        else if let yValue = chartPoints.first(where: {$0.reference == reference }) {
//            self.selected = (reference, yValue.value)
//            print("yooo")
//        }
    }

}


#Preview {
//    ItemChart(chartPoints: MockData.mars.chartData, showZero: true)
//    { xValue in
//        MockData.mars.point(for: xValue)?.altitude ?? 0
//    }
    return ItemChart<Cloud.Data>(chartPoints: MockData.clouds.chartData)
}
