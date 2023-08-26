//
//  SkiesTabView.swift
//  CelestialAbove
//
//  Created by Michael on 5/12/23.
//

import SwiftUI
import SwiftData

struct SkiesTabView: View {
    @Environment(\.dismiss) var dismiss
    @Query var skies: [Sky]
    
    @State var selected: Sky
    
    var body: some View {
        TabView(selection: $selected) {
            ForEach(skies){ sky in
                SkyView(sky: sky)
                    .tag(sky)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(systemName: "map", action: openMap)
            }
            ToolbarItem(placement: .status) {
                TabIndexView(selected: selected, skies: skies)
            }
            ToolbarItem(placement: .bottomBar) {
                Button(systemName: "list.bullet") {
                    dismiss()
                }
            }
        }
        .foregroundColor(.white)
        .background(selected.color)
    }
    
    private func openMap(){
        guard let url = URL(string: "maps://?saddr=&daddr=\(selected.location.coordinate.latitude),\(selected.location.coordinate.longitude)") else {return}
        if UIApplication.shared.canOpenURL(url) {
              UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}

struct TabIndexView: View {
    
    let selected: Sky
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
