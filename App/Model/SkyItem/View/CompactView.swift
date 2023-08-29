//
//  CompactView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/28/23.
//

import SwiftUI

struct CompactView: View {
    let title: String
    var subtitle: String? = nil
    var alignment: HorizontalAlignment = .center
    
    var body: some View {
        VStack(alignment: alignment) {
            Text(title)
            if let subtitle {
                Text(subtitle)
            }
        }
    }
}

#Preview {
    CompactView(title: "Title", subtitle: "subtitle", alignment: .leading)
}
