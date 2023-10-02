//
//  ItemDetailView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/1/23.
//

import SwiftUI

struct ItemDetailView<Header: View, Chart:View>: View {
    let title: String
    let symbolName: String
    
    var detail: String? = nil
    var subtitle: String? = nil
    var subtdetail: String? = nil
    
    @ViewBuilder
    var header: Header
    
    @ViewBuilder
    var chart: Chart
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    header
                    chart
                    ItemSmall(label: detail ?? title, detail: detail) {
                        Image(systemName: symbolName)
                    }
                    
                }
            }
            .navigationTitle(title)
        }
    }
}



//#Preview {
//    ItemDetailCell()
//}
