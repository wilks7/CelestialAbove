//
//  ItemView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import WeatherKit


struct SkyGridCell<V:View>: View {
    let title: String
    let symbolName: String
    
    @ViewBuilder
    var content: V
    @State private var showSheet = false

    var body: some View {
        VStack {
            ItemHeader(title: title, symbolName: symbolName)
                .background(Color.red)
                .onTapGesture {
                    showSheet = true
                }
            content
        }
        .padding(8)
        .sheet(isPresented: $showSheet) {
            Text("Hi")
        }
        .transparent()
    }
}

extension SkyGridCell {
    init<I:WeatherItem>(_ type: I.Type, hour: HourWeather, _ hourly: [HourWeather], day: DayWeather?) where V == SmallView<I.Constant> {
        let item = I(hour: hour, hourly, day: day)
        self.title = item.title
        self.symbolName = item.symbolName
        self.content = SmallView(item: item)
    }
}


//struct SkyItemView<I:SkyItem>: View {
////    @EnvironmentObject var sky: Sky
//    enum Size: String, CaseIterable { case small, medium, large }
//    enum ViewType { case detail, chart }
//
//    let item: I
//    @State var size: Size
//    @State var type: ViewType = .detail
//
//    @State private var showSheet = false
//    
//    var body: some View  {
//        SkyGridCell(title: item.title, symbolName: item.symbolName) {
//
//            Group {
//                switch size {
//                case .small: 
//                    Group {
//                        if type == .detail {
//                            SmallView(item: item)
//                        } else {
//                            ItemChartView(item: item)
//                        }
//                    }
//                        .onTapGesture {
//                            withAnimation{
//                                self.type = self.type == .detail ? .chart : .detail
//                            }
//                        }
//                case .medium: MediumView(item: item)
//                case .large: LargeView(item: item)
//                }
//            }
//        }
//    }
//
//}

//extension SkyItemView {
//
//    init(_ item: I, _ size: Size = .small) where I == CelestialEvents {
//        self.item = item
//        self._size = State(initialValue: size)
//    }
//
//    init(hour: HourWeather, _ hourly: [HourWeather], day: DayWeather?, size: Size = .small) where I: WeatherItem {
//        self.item = I(hour: hour, hourly, day: day)
//        self._size = State(initialValue: size)
//    }
//
//}
//
//struct SkyItem_Previews: PreviewProvider {
//    static var previews: some View {
//        SkyItemView(MockData.mars)
//        SkyItemView(MockData.mars, .medium)
//        SkyItemView(MockData.mars, .large)
//    }
//}


protocol ItemViewProtocol: View {
    associatedtype Small: View
    associatedtype Medium: View
    associatedtype Large: View
    
    var small: Small {get}
    var medium: Medium {get}
    var large: Large {get}
}
