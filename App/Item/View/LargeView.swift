//
//  ItemViewLarge.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import SwiftUI

struct LargeView<I:SkyItem>: View {
    let item: I
    var body: some View {
        Text(item.title)
    }
}

struct ItemViewLarge_Previews: PreviewProvider {
    static var previews: some View {
        LargeView(item: event)
    }
}
