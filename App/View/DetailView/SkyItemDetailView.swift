//
//  SkyItemDetailView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import WeatherKit
import CoreLocation
import SwiftAA



struct SkyItemDetailView<S:SkyItem>: View {
    
    let item: S
    
    var body: some View {
        ScrollView {
            VStack {
                Text(item.symbolName.capitalized)
                    .font(.largeTitle)
                item.glyph
                item.medium
                item.chart
            }
        }
    }
}
//extension SkyItemDetailView {
//    init<S:SkyItem>(item: S)
//    where Constant == S.Constant,
//    Detail == SmallView<S.Constant>,
//    Chart == ItemChart<S.Data>
//    {
//        self.title = S.title
//        self.detail = SmallView(item: item)
//        self.chart = ItemCh
//        
//        self.constant = item.constant
//    }
//}
    
//    struct Header:View {
//        let weather: DayWeather?
//        @Binding var item: DetailItem
//        
//        var symbolName: String {
//            item.systemName(for: weather)
//        }
//        
//        var body: some View {
//            HStack {
//                VStack {
//                    Image(systemName: symbolName)
//                        .font(.largeTitle)
//                    Text(item.title.capitalized)
//                        .font(.largeTitle)
//
//                }
//                Spacer()
//                #if !os(watchOS)
//                Menu {
//                    Picker("", selection: $item) {
//                        ForEach(DetailItem.allCases) {
//                            Label($0.title.capitalized, image: $0.systemName(for: weather))
//                                .tag($0)
//                        }
//                    }
//                } label: {
//                    HStack {
//                        Image(systemName: symbolName)
//                        Image(systemName: "chevron.down")
//                            .fontWeight(.semibold)
//                    }
//                    .foregroundColor(.white)
//                    .font(.title2)
//                }
//                #endif
//            }
//        }
//    }

//#Preview {
////    SkyItemDetailView(title: "Title", subtitle: "Sub Title String", label: "Label String", detail: "Detail", subDetail: "Sub Detail String") {
////        MockData.mars.constant
////    } chart: {
////        ItemChart(chartPoints: MockData.mars.locations)
////    }
//    
//    SkyItemDetailView(item: MockData.mars) {
//        ItemChart<CelestialEvents.Location>(chartPoints: MockData.mars.locations)
//    }
//
//}
