//
//  SkyView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI

struct SkyView: View {
    @ObservedObject var sky: Sky
    
    var body: some View {
        List {
            ForEach(1..<10){ section in
                Section {
                    ForEach(1..<5) { cell in
                        Text(cell.description)
                    }
                } header: {
                    Text(section.description)
                }
            }
            .listRowBackground(Color.blue)
        }
        .listStyle(.plain)
        .background(Color.indigo)
        .scrollContentBackground(.hidden)

    }
}

struct SkyView_Previews: PreviewProvider {
    static var previews: some View {
        SkyView(sky: NY)
    }
}
