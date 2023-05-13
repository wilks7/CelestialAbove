//
//  SkyTitle.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI

struct SkyTitle: View {
    
    let title: String
    let isCurrent: Bool
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

struct SkyTitle_Previews: PreviewProvider {
    static var previews: some View {
        SkyTitle(title: sky.title, isCurrent: false)
        SkyTitle(title: sky.title, isCurrent: true)
    }
}
