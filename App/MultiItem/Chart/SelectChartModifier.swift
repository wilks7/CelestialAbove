//
//  SelectChartModifier.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/1/23.
//

import SwiftUI
import Charts

struct SelectChartOverlay<X:Plottable,Y:Plottable>:ViewModifier {
    
    public typealias PointFor = (X) -> Y
    public typealias ChartPoint = (X,Y)
        
    @Binding var selected: ChartPoint?
    
    let pointFor: PointFor
    
    let check: (X)->Bool
    
    @State private var longPressed = false

    func body(content: Content) -> some View {
        content.chartOverlay { proxy in
            GeometryReader { geometry in
                    Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        LongPressGesture(minimumDuration: 0.2)
                            .onEnded { _ in
                                self.longPressed = true
                            }
                    )
                    .simultaneousGesture(
                        longPressed ?
                        DragGesture()
                            .onChanged { drag in
                                handleDrag(on: proxy, with: geometry, from: drag)
                            }
                            .onEnded { _ in
                                self.longPressed = false
                                self.selected = nil
                            }
                        : nil
                    )
            }
        }
    }
    
    private func handleDrag(on proxy: ChartProxy, with geometry: GeometryProxy, from drag: DragGesture.Value){
        guard let point = chartPoint(on: proxy, with: geometry, from: drag)
            else {return}
        
        let reference = point.0
        
        if check(reference) {
            let value = pointFor(reference)
            self.selected = (reference, value)
        }
//        else if let pointData = points.first(where: {$0.0 == reference }) {
//            self.selected = (reference, pointData.1)
//        }
    }
    
    private func chartPoint(on proxy: ChartProxy, with geometry: GeometryProxy, from drag: DragGesture.Value) -> (X,Y)? {
        
        guard let plotFrame = proxy.plotFrame else {return nil }
        
        let origin = geometry[plotFrame].origin
        let location = CGPoint(
            x: drag.location.x - origin.x,
            y: drag.location.y - origin.y
        )
        
        return proxy.value(at: location, as: (X, Y).self)
    }
    
    
}

extension View {

    public func selectOverlay<X:Plottable,Y:Plottable>(
        selected: Binding<(X,Y)?>,
        pointFor: @escaping((X) -> Y),
        checkFor: @escaping (X)->Bool
    ) -> some View  {
        self
        .modifier(SelectChartOverlay(selected: selected, pointFor: pointFor, check: checkFor))
    }

}
