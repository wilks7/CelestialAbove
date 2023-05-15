//
//  ItemView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import WeatherKit

struct SkyItem<I:Item>: View {
    @EnvironmentObject var sky: Sky
    enum Size: String, CaseIterable { case small, medium, large }
    
    let item: I
    @State var size: Size
    
    @State private var showSheet = false
    
    var body: some View  {
        VStack {
            ItemHeader(title: item.title, symbolName: item.symbolName)
                .onTapGesture(perform: showDetail)
            Group {
                switch size {
                case .small: ItemViewSmall(item: item)
                case .medium: ItemViewMedium(item: item)
                case .large: ItemViewLarge(item: item)
                }
            }
        }
        .padding(8)
        .sheet(isPresented: $showSheet) {
            VStack{
                Spacer()
                Text("Hi Sheet")
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private func showDetail() {
        self.showSheet = true
    }
}

extension SkyItem {
    
    init(_ item: I, _ size: Size = .small) {
        self.item = item
        self._size = State(initialValue: size)
    }
    
    init(_ weather: Weather, _ size: Size = .small) where I: WeatherItem {
        self.item = I(weather)
        self._size = State(initialValue: size)
    }

}

struct SkyItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SkyItem(event)
            SkyItem(event, .medium)
            SkyItem(event, .large)
        }
            .environmentObject(sky)
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
