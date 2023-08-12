//
//  SkyCellView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/17/23.
//

import SwiftUI

struct SkyCellView<TopTrailing: SkyItem, BottomLeading: SkyItem, BottomTrailing: SkyItem>: View {
    let sky: Sky
        
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0){
                    SkyTitle(title: sky.title ?? "Title", isCurrent: sky.currentLocation ?? false)
                    Text( Date.now.time(sky.timezone) )
                        .font(.footnote.weight(.semibold))
                }
                Spacer()
                TopTrailing(sky)?.compact(.trailing)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .padding(.bottom)
            HStack(alignment: .bottom) {
                BottomLeading(sky)?.compact(.leading)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()
                BottomTrailing(sky)?.compact(.trailing)
            }
        }
        .foregroundColor(.white.opacity(0.9))
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(sky.color)
        .cornerRadius(16)
    }
}

//struct SkyCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        SkyCellView()
//    }
//}
