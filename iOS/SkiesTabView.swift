////
////  SkiesTabView.swift
////  CelestialAbove
////
////  Created by Michael on 5/12/23.
////
//
//import SwiftUI
//import SwiftData
//import AppIntents
//
//struct SkiesTabView: View {
//    @Environment(\.dismiss) var dismiss
//    let skies: [Sky]
//    @State var selected: Sky
//    @State private var showScene = false
//    
//    var body: some View {
//        TabView(selection: $selected) {
//            ForEach(skies){ sky in
//                SkyGridView(sky: sky)
//                    .tag(sky)
//            }
//        }
//        .tabViewStyle(.page(indexDisplayMode: .never))
//
//    }
//    
//    
//    //    private func openMap(){
//    //        guard let url = URL(string: "maps://?saddr=&daddr=\(selected.location.coordinate.latitude),\(selected.location.coordinate.longitude)") else {return}
//    //        if UIApplication.shared.canOpenURL(url) {
//    //              UIApplication.shared.open(url, options: [:], completionHandler: nil)
//    //        }
//    //    }
//
//}
//
//extension SkiesTabView {
//    
//    private struct TabIndexView: View {
//        
//        let selected: Sky
//        let skies: [Sky]
//        
//        var body: some View {
//            HStack(spacing: 10) {
//                ForEach(skies) { sky in
//                    Group {
//                        if sky.currentLocation {
//                            Image(systemName:"location.fill")
//                                .font(.caption2)
//                        } else {
//                            Circle().frame(width: 8, height: 8)
//                        }
//                    }
//                    .foregroundStyle(sky == selected ? .white : .white.opacity(0.5) )
//                }
//            }
//        }
//    }
//}
//
////#Preview {
////    SkiesTabView(skies: <#T##[Sky]#>, selected: <#T##Sky#>, showScene: <#T##arg#>)
////}
