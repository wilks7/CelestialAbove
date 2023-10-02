
import SwiftUI
import Charts

public struct ItemChart<X:Plottable, Y:Plottable>: View where X: Hashable, Y: Hashable, X:Comparable, Y:Comparable {
    
    public typealias PointFor = (X) -> Y
    public typealias ChartPoint = (X,Y)
    
    public var chartPoints: [(X,Y)]
    
    public var now: ChartPoint? = nil
    public var showZero = false
    @Binding var selected: ChartPoint?

    


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
            } 
            else if let now {
                PointMark(
                    x: .value("Time", now.0),
                    y: .value("Value", now.1)
                )
                .foregroundStyle(.white)
            }
        }
        .chartYAxis(.hidden)

    }
    

}

extension ItemChart {
    init(points: [ChartPoint], showZero: Bool = false, now: ChartPoint? = nil){
        self.chartPoints = points
        self.showZero = showZero
        self._selected = .constant(now)
    }
    
}
