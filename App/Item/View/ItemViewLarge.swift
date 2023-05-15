//
//  ItemViewLarge.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import SwiftUI

struct ItemViewLarge<I:Item>: View {
    let item: I
    var body: some View {
        Text(item.title)
    }
}

struct ItemViewLarge_Previews: PreviewProvider {
    static var previews: some View {
        ItemViewLarge(item: event)
    }
}
