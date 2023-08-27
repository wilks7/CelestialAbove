//
//  ItemSmallView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import SwiftUI

struct SmallView<C:View>: View {
    enum ViewType { case detail, chart }
    let label: String?
    let subtitle: String?
    
    @ViewBuilder
    var constant: C
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label ?? "--")
                .font(.title2)
                .fontWeight(.semibold)
            constant
                .frame(width: 70, height: 70)
            Text(subtitle ?? "--")
//                .font(.headline)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
}

extension SmallView {
    init<S:SkyItem>(item: S) where C == S.Constant {
        self.label = item.label
        self.subtitle = item.subtitle
        self.constant = item.constant
    }
    
}

#Preview {
    SmallView(item: MockData.mars)
}

