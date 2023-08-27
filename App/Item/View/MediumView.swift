////
////  ItemViewMedium.swift
////  CelestialAbove
////
////  Created by Michael Wilkowski on 5/15/23.
////
//
//import SwiftUI
//
//struct MediumView<I:SkyItem>: View {
//    enum ViewType { case detail, chart }
//
//    let item: I
//    @State var type: ViewType = .chart
//
//    var body: some View {
//        Group {
//            if type == .detail {
//                HStack {
//                    item.constant
//                        .frame(width: 70, height: 70)
//                    Spacer()
//                    VStack {
//                        Text(item.label ?? "--")
//                        Text(item.subtitle ?? "--")
//                        Text(item.detail ?? "--")
//                    }
//                }
//            }
//            else {
//                ItemChartView(item: item)
//            }
//        }
//        .onTapGesture {
//            withAnimation {
//                self.type = self.type == .detail ? .chart : .detail
//            }
//        }
//    }
//}
//
//struct ItemViewMedium_Previews: PreviewProvider {
//    static var previews: some View {
//        MediumView(item: MockData.mars)
//    }
//}

//struct LargeView<I:SkyItem>: View {
//    let item: I
//    var body: some View {
//        Text(item.title)
//    }
//}
//
//struct ItemViewLarge_Previews: PreviewProvider {
//    static var previews: some View {
//        LargeView(item: MockData.mars)
//    }
//}
