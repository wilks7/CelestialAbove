//
//  SkiesTabView.swift
//  CelestialAbove
//
//  Created by Michael on 5/12/23.
//

import SwiftUI

struct SkiesTabView: View {
    @EnvironmentObject var navigation: NavigationManager

    let skies: FetchedResults<Sky>
    @State var selected: Sky
    
    var body: some View {
            TabView(selection: $selected) {
                ForEach(skies){ sky in
                    SkyView(sky: sky)
                        .tag(sky)
                }
            }
            .navigationTitle(selected.title)
            .background(selected.color)
        #if !os(macOS)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(systemName: "map") {
                        
                    }
                    .foregroundColor(.white)
                }
                ToolbarItem(placement: .status) {
                    Dots(skies: skies.map{$0}, selected: selected)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(systemName: "list.bullet") {
                        navigation.navigateList()
                    }
                    .foregroundColor(.white)
                }
            }
        #endif
    }
    
    struct Dots: View {
        let skies: [Sky]
        let selected: Sky?
        
        func color(for sky: Sky) -> Color {
            if sky == selected {
                return .white
            } else {
                return Color.white.opacity(0.5)
            }
        }
        
        
        var body: some View {
            HStack(spacing: 10) {
                ForEach(skies, id: \.self) { sky in
                    let color: Color = color(for: sky)

                    if sky.currentLocation {
                        Image(systemName: "location.fill")
                            .font(.caption2)
                            .offset(y: 0)
                            .foregroundColor(color)
                    } else {
                        Circle().fill(color)
                            .frame(width: 7, height: 7)
                    }
                }
            }
        }
    }

}


//struct SkiesTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        SkiesTabView()
//    }
//}
