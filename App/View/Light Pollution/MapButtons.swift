//
//  MapOverlay.swift
//  SkyAbove
//
//  Created by Michael Wilkowski on 1/17/23.
//

import SwiftUI
import CoreLocation
import SwiftData

struct MapButtonsOverlay: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var location: CLLocation
    @State private var showSkies = false

    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                Button { dismiss() } label: {
                    Text("Done")
                        .fontWeight(.semibold)
                        .padding(.vertical, 4)
                }
                .tint(Color(uiColor: .systemGray4))
                .buttonStyle(.borderedProminent)
                BortleScale()
            }
            Spacer()
            buttons
        }
        .foregroundColor(.primary)
        .padding()
        .sheet(isPresented: $showSkies) {
            ChooseSkyView(showSkies: $showSkies, location: $location)
        }
    }
    
    var buttons: some View {
        VStack(spacing: 10) {
            VStack(spacing: 0) {
                Button(systemName: "location") {
                    
                }
                .padding(8)
                .background(Color(uiColor: .systemGray4))
                .cornerRadius(8)// corners: [.topLeft, .topRight])

                Divider().frame(width: 40)
                
                Button(systemName: "list.bullet") {
                    showSkies = true
                }
                .padding(8)
                .background(Color(uiColor: .systemGray4))
                .cornerRadius(8)// corners: [.bottomLeft, .bottomRight])
            }
            
            Button(systemName: "square.stack.3d.up") {
                
            }
            .padding(8)
            .background(Color(uiColor: .systemGray4))
            .cornerRadius(8)


        }
        .font(.title3)
//        .buttonStyle(.borderedProminent)
    }
}

struct ChooseSkyView: View {
    @Binding var showSkies: Bool
    @Binding var location: CLLocation

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Sky.currentLocation_, ascending: false)],
//        animation: .default)
//    private var skies: FetchedResults<Sky>
    #warning("fix")
    let skies: [Sky] = []
//    @Query private var skies: [Sky]

    var body: some View {
        List {
            Section {
                ForEach(skies, id: \.id) { sky in
                    HStack {
                        Text(sky.title ?? sky.id)
                        Spacer()
//                        Text(sky.days.today?.day?.percent.percentString ?? "--")
                    }
                    .onTapGesture {
                        withAnimation {
                            self.location = sky.location
                            self.showSkies = false
                        }

                    }
                }

            } header: {
                HStack {
                    Image(systemName: "eye")
                    VStack {
                        Text("Light Pollution")
                        Text("Skies")
                    }
                    Spacer()
                    Button(systemName: "x.circle.fill") {
                        showSkies = false
                    }
                }
            }
        }
            .presentationDetents([.medium, .large])
    }
}

struct BortleScale: View {
    
    private let size: CGFloat = 400
    
    var colors: [Color] {
        var colors: [Color] = []
        for i in 1..<15 {
            colors.append(Color("bortle_\(i)"))
        }
        colors.append(.white)
        return colors
    }
    
    var gradient: Gradient { Gradient(colors: colors) }

    @State private var collapse = false

    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Bortle Zone")
                    .font(.footnote)
            }
            if !collapse {
                HStack {
                    Capsule()
                        .fill(gradient)
                        .frame(width: 10, height: size)
                    VStack(alignment: .leading) {
                        ForEach(values, id: \.self){ value in
                            if value != "<0.01" {
                                Spacer()
                            }
                            Text(value)
                        }

                    }.font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(height: size)
                .padding(.bottom, 8)
            }

        }
        .padding(8)
        .background(.ultraThinMaterial)
//        .background(Color(uiColor: .systemGray5))
        .cornerRadius(8)
        .onTapGesture {
            collapse.toggle()
        }
    }
}

extension BortleScale {
    
    var values: [String] { [
        "<0.01",
        "0.01 - 0.06",
        "0.06 - 0.11",
        "0.11 - 0.19",
        "0.19 - 0.33",
        "0.33 - 0.58",
        "0.58 - 1.00",
        "1.00 - 1.73",
        "1.73 - 3.00",
        "3.00 - 5.20",
        "5.20 - 9.00",
        "9.00 - 15.59",
        "15.59 - 27.00",
        "27.00 - 46.77",
        ">46.77"
        ]
    }
}



//struct BortleScale_Previews: PreviewProvider {
//    static var previews: some View {
//        LightPollutionView(location: sky.location).sheet
//        ChooseSkyView(showSkies: .constant(true), location: .constant(sky.location))
//            .preferredColorScheme(.dark)
//            .previewDisplayName("Choose Sky")
//    }
//}

//: DevPreview {
//    static var previews: some View {
//        LightPollutionView(location: dev.sky.location).sheetView
//        ChooseSkyView(showSkies: .constant(true), location: .constant(dev.sky.location))
//            .environment(\.managedObjectContext, dev.coreData.context)
//            .preferredColorScheme(.dark)
//            .previewDisplayName("Choose Sky")
//    }
//}
