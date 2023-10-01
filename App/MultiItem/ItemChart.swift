
import SwiftUI
import Charts

public struct ItemChart<X:Plottable, Y:Plottable>: View where X: Hashable, Y: Hashable, X:Comparable, Y:Comparable {
    public typealias PointFor = (X) -> Y
    public typealias ChartPoint = (X,Y)
    
    public var chartPoints: [(X,Y)]
    public var now: ChartPoint? = nil
    public var pointFor: PointFor? = nil
    public var showZero = false

    @State private var selected: ChartPoint? = nil

    public var body: some View {
        Chart {
            ForEach(chartPoints, id: \.self.0){
                LineMark(
                    x: .value("Time", $0.0),
                    y: .value("Value", $0.1)
                )
                .lineStyle(.init(lineWidth: 4))
            }
            if showZero {
                RuleMark(y: .value("Value", 0))
                    .foregroundStyle(.white)
            }
            if let selected {
                RuleMark(x: .value("Time", selected.0))
                    .foregroundStyle(.gray)
                    .annotation(position: .overlay) {
                        if let date = selected.0 as? Date {
                            Text(date.formatted())
                                .font(.caption)
                        }
                    }
                PointMark(
                    x: .value("Time", selected.0),
                    y: .value("Value", selected.1)
                )
                .foregroundStyle(.white)
            } else if let now {
                PointMark(
                    x: .value("Time", now.0),
                    y: .value("Value", now.1)
                )
                .foregroundStyle(.white)
            }
        }
        .chartYAxis(.hidden)
        .selectOverlay(selected: $selected, pointFor: pointFor, checkFor: check(reference:))

    }
    
    func check(reference: X) -> Bool{
        #warning("better guard")
        if let first = chartPoints.first?.0,
           let last = chartPoints.last?.0 {
            
            return reference >= first && reference <= last
        } else {
            return false
        }
    }
}
