//
//  ItemSmallView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import SwiftUI

struct SmallView<C:View>: View {
    enum ViewType { case detail, chart }
    let title: String
    var detail: String? = nil
    var constant: C
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            constant
//                .frame(width: 70, height: 70)
            if let detail {
                Text(detail)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }

        }
//        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
}
//
//extension SmallView {
//    init<S:SkyItem>(item: S) where C == S.Constant {
//        self.label = item.label
//        self.subtitle = item.subtitle
//        self.constant = item.constant
//    }
//    
//}

//#Preview {
//    SmallView(item: MockData.mars)
//}
//
