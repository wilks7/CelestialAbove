//
//  SkiesTabView.swift
//  CelestialAbove
//
//  Created by Michael on 5/12/23.
//

import SwiftUI
import SwiftData

struct SkiesTabView: View {
    @EnvironmentObject var navigation: NavigationManager
    @Query private var skies: [Sky]
    
    @State var selected: Sky
    
    var body: some View {
        TabView(selection: $selected) {
            ForEach(skies){ sky in
                SkyView(sky: sky)
                    .tag(sky)
            }
        }
        #if !os(macOS)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(systemName: "map") {}
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .status) {
                    TabIndexView(selected: selected, skies: skies)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(systemName: "list.bullet") {
                        navigation.navigateList()
                    }
                        .foregroundColor(.white)
                }
            }
        #endif
        .background(selected.color)

    }
    
}

struct TabIndexView: View {
    
    let selected: Sky?
    let skies: [Sky]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(skies) { sky in
                Group {
                    if (sky.currentLocation ?? false) {
                        Image(systemName:"location.fill")
                            .font(.caption2)
                    } else {
                        Circle().frame(width: 8, height: 8)
                    }
                }
                .foregroundStyle(sky == selected ? .white : .white.opacity(0.5) )
            }
        }
    }
}


//struct SkiesTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        SkiesTabView()
//    }
//}
