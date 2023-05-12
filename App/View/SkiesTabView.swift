//
//  SkiesTabView.swift
//  CelestialAbove
//
//  Created by Michael on 5/12/23.
//

import SwiftUI

struct SkiesTabView: View {
    let skies: FetchedResults<Sky>
    @Binding var selected: Sky?

    var body: some View {
        TabView(selection: $selected) {
            ForEach(skies){ sky in
                SkyView(sky: sky)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Dismiss"){
                    withAnimation {
                        self.selected = nil
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
