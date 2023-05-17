////
////  SkyCell.swift
////  CelestialAbove
////
////  Created by Michael Wilkowski on 5/11/23.
////
//
//import SwiftUI
//
//struct SkyCell: View {
//    @ObservedObject var sky: Sky
//
//    var font: Font = .subheadline
//    var subFont: Font = .title2
//
//    var body: some View {
//        VStack(spacing: 0) {
//            HStack(alignment: .top) {
//                VStack(alignment: .leading, spacing: 0){
//                    SkyTitle(title: sky.title, isCurrent: sky.currentLocation)
//                    Text( Date.now.time(sky.timezone) )
//                        .font(.footnote.weight(.semibold))
//                }
//                Spacer()
//                PercentView(percent: sky.weather?.today?.percent ?? 2.0, size: 32)
//            }
//            .padding(.bottom)
//            HStack(alignment: .bottom) {
//                if let events = sky.events.first {
//                    VStack(alignment: .leading, spacing: 0) {
//                        events.constant
//                            .frame(width: 30, height: 30)
//                        Text(events.nextTime ?? "--")
//                    }
//                    .font(font)
//                    .fontWeight(.medium)
//                }
//                Spacer()
//                if let clouds = sky.weather?.clouds {
//                    VStack(alignment: .trailing) {
//                        Image(systemName: "circle")
//                        Text("Cloudy")
//                            .shadow(color: .red, radius: 20)
//                    }
//                }
//                .font(font)
//                .fontWeight(.semibold)
//            }
//        }
//        .foregroundColor(.white.opacity(0.9))
//        .padding(.horizontal)
//        .padding(.vertical, 8)
//        .background(sky.color)
//        .cornerRadius(16)
//    }
//}
//
//struct SkyCell_Previews: PreviewProvider {
//    static var previews: some View {
//        List {
//            SkyCell(sky: sky)
//        }
//        .listStyle(.plain)
//    }
//}
