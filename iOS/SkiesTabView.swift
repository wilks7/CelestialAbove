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
        NavigationStack {
            TabView(selection: $selected) {
                ForEach(skies){ sky in
                    SkyView(sky: sky)
                        .tag(sky)
                }
            }
            .navigationTitle(selected.title)
            .background(selected.color)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(systemName: "map") {
                        
                    }
                    .foregroundColor(.white)
                }
                ToolbarItem(placement: .status) {
                    TabDots(skies: skies.map{$0}, selected: selected)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(systemName: "list.bullet") {
                        navigation.navigateList()
                    }
                    .foregroundColor(.white)
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
