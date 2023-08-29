//
//  SkyCellView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/17/23.
//

import SwiftUI

struct SkyCellView<TopTrailing: View, BottomLeading: View, BottomTrailing: View>: View {
    let title: String
    let timezone: TimeZone
    
    @ViewBuilder
    var topTrailing: TopTrailing
    
    @ViewBuilder
    var bottomTrailing: BottomTrailing
    
    @ViewBuilder
    var bottomLeading: BottomLeading
        
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0){
                    SkyTitle(title: title)
                    Text( Date.now.time(timezone) )
                        .font(.footnote.weight(.semibold))
                }
                Spacer()
                topTrailing
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .padding(.bottom)
            HStack(alignment: .bottom) {
                bottomLeading
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()
                bottomTrailing
            }
        }
        .foregroundColor(.white.opacity(0.9))
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

extension SkyCellView {
    
}

extension SkyCellView {
    struct SkyTitle: View {
            
        let title: String
        var isCurrent: Bool = false
        var font: Font? = nil
        var weight: Font.Weight = .bold
        var alignment: HorizontalAlignment = .leading
    
        var body: some View {
            HStack(alignment: .top) {
                if isCurrent && alignment == .trailing {
                    image
                }
                Text(title)
                if isCurrent && alignment == .leading {
                    image
                }
            }
            .font(font)
            .fontWeight(weight)
        }
    
        var image: some View {
            Image(systemName: "location.fill")
                .scaleEffect(0.8)
        }
    }
    

}

extension SkyCellView.SkyTitle {
    init(sky: Sky){
        self.title = sky.title ?? sky.id
        self.isCurrent = sky.currentLocation ?? false
    }
}

//struct SkyCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        SkyCellView()
//    }
//}
