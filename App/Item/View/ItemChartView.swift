////
////  ItemChartView.swift
////  CelestialAbove
////
////  Created by Michael Wilkowski on 5/16/23.
////
//
//import SwiftUI
//import Charts
//
//struct ItemChartView<I:SkyItem>: View {
//    typealias D = I.Data
//    let item: I
//    @State var selected: D?
//    
//    var points: [D] { item.chartData }
//    
//    var body: some View {
//        Chart {
//            if let selected {
//                selected.rulemark
//                    .foregroundStyle(.gray)
//            }
//            ForEach(points){
//                $0.linemark
//                .lineStyle(.init(lineWidth: 4))
//            }
//            if let selected {
//                selected.point
//                .foregroundStyle(.white)
//            } else if let point = point(for: Date.now)  {
//                PointMark(
//                    x: .value("Time", Date.now),
//                    y: .value("Value", point.reference)
//                )
//                .foregroundStyle(.white)
//            }
//        }
//    }
//    
//    private func point(for date: Date) -> D? {
//        item.point(for:date)
//    }
//}
//
//struct ItemChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemChartView(item: MockData.venus)
//    }
//}
