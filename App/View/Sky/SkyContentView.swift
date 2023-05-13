//
//  SkyContentView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI

struct SkyContentView<Content: View, Header: View>: View {
    let color: Color
    var header: Header
    @ViewBuilder var content: Content
    var body: some View {
        List {
            header
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            content
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .cornerRadius(16)
        }
        .listStyle(.plain)
//        .background(color)
        .scrollContentBackground(.hidden)
    }
}

struct SkyContentView_Previews: PreviewProvider {
    
    static var header: some View {
        VStack {
            HStack {
                Spacer()
                Text("90%")
                    .font(.system(size: 82))
                Spacer()
            }
        }
    }
    static var previews: some View {
        SkyContentView(color: .indigo, header: header) {
            ForEach(1..<40) { i in
                Text("Index: \(i)")
                    .font(.title3)
            }
        }
    }
}
