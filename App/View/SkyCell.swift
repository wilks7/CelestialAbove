//
//  SkyCell.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI

struct SkyCell: View {
    @ObservedObject var sky: Sky
    
    var font: Font = .subheadline
    
    var timeString: String {
        let format = Date.FormatStyle(date: .omitted, time: .shortened, timeZone: sky.timezone)
        return Date.now.formatted(format)
    }
    

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0){
                    SkyTitle(title: sky.title, isCurrent: sky.currentLocation)
                    Text(timeString)
                        .font(.footnote.weight(.semibold))
                }
                Spacer()
                Text("80%").font(.largeTitle)
            }
            
            HStack(alignment: .bottom) {
                VStack(alignment: .trailing, spacing: 0) {
                    Circle().frame(width: 30, height: 30)
                    Text(Date.now.formatted(date: .omitted, time: .shortened) )
                }
                .font(font)
                .fontWeight(.medium)
                Spacer()
                VStack(alignment: .trailing) {
                    Image(systemName: "circle")
                    Text("Cloudy")
                        .shadow(color: .red, radius: 20)
                }
                .font(font)
                .fontWeight(.semibold)
            }
        }
        .foregroundColor(.white.opacity(0.9))
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct SkyCell_Previews: PreviewProvider {
    static var previews: some View {
        SkyCell(sky: NY)
    }
}
