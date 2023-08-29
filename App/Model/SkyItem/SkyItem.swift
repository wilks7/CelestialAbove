//
//  SkyItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import Charts

protocol SkyItem {
    associatedtype DataY:Plottable, Comparable, Hashable
    associatedtype Compact:View
    associatedtype Chart:View
    associatedtype Small:View
    associatedtype Medium: View
    associatedtype Glyph: View

    var label: String {get}
    var detail: String? {get}
    var symbolName: String {get}

    var compact: Compact {get}
    var small: Small {get}
    var medium: Medium {get}

    var chart: Chart {get}
    var glyph: Glyph {get}
    
    func data(for _: ClosedRange<Date>, component: Calendar.Component) -> [(Date,DataY)]

}

extension SkyItem {
    var compact: some View {
        CompactView(title: label, subtitle: detail)
    }
    
    var small: some View {
        SmallView(title: label, detail: detail, constant: glyph)
    }
    
    var medium: some View {
        HStack {
            glyph
                .frame(width: 70, height: 70)
            Spacer()
            VStack {
                Text(label)
                Text(detail ?? "--")
            }
        }
    }
    
    var glyph: some View {
        Image(systemName: symbolName)
    }
    
}
