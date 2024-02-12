//
//  NewSkyView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI

struct NewSkyView: View {
    @Environment(\.dismiss) private var dismiss
    
    let searchSky: SkyKey
    var add: (SkyKey) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(searchSky.title)
                Text(searchSky.location.id)
                Text(searchSky.timezone.identifier)
            }
                .toolbar {
                    ToolbarItem {
                        Button("Add", action: addSky)

                    }
                    ToolbarItem {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
        }
    }
    
    private func addSky(){
        add(searchSky)
        dismiss()
    }
}

struct NewSkyView_Previews: PreviewProvider {
    static var previews: some View {
        NewSkyView(searchSky: .init(
            title: "New York",
            location: .init(latitude: 40.7831, longitude: -73.9712),
            timezone: TimeZone(identifier: "America/New_York")!)) { sky in}
    }
}
