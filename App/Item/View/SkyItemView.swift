//
//  ItemView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import WeatherKit

struct SkyItemView<I:SkyItem>: View {
//    @EnvironmentObject var sky: Sky
    enum Size: String, CaseIterable { case small, medium, large }
    enum ViewType { case detail, chart }

    let item: I
    @State var size: Size
    
    @State private var showSheet = false
    
    var body: some View  {
        VStack {
            ItemHeader(title: item.title, symbolName: item.symbolName)
                .onTapGesture(perform: showDetail)
            Group {
                switch size {
                case .small: SmallView(item: item)
                case .medium: MediumView(item: item)
                case .large: LargeView(item: item)
                }
            }
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
    
    private func showDetail() {
        self.showSheet = true
    }
}

extension SkyItemView {

    init(_ item: I, _ size: Size = .small) where I == CelestialEvents {
        self.item = item
        self._size = State(initialValue: size)
    }

    init(hour: HourWeather, _ hourly: [HourWeather], day: DayWeather?, size: Size = .small) where I: WeatherItem {
        self.item = I(hour: hour, hourly, day: day)
        self._size = State(initialValue: size)
    }

}

struct SkyItem_Previews: PreviewProvider {
    static var previews: some View {
        SkyItemView(event)
        SkyItemView(event, .medium)
        SkyItemView(event, .large)
    }
}


protocol ItemViewProtocol: View {
    associatedtype Small: View
    associatedtype Medium: View
    associatedtype Large: View
    
    var small: Small {get}
    var medium: Medium {get}
    var large: Large {get}
}
