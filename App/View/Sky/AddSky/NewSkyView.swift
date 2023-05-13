//
//  NewSkyView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI

struct NewSkyView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var model: SearchResults
    @Environment(\.dismiss) private var dismiss

    let searchSky: SearchResults.Sky
    var body: some View {
        NavigationStack {
            VStack {
                Text(searchSky.title)
                Text(searchSky.location.id)
                Text(searchSky.timezone.identifier)
            }
                .toolbar {
                    ToolbarItem {
                        Button("Add") {

                        }
                    }
                    ToolbarItem {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
        }
    }
    
    private func add(){
        let sky = Sky(context: context, title: searchSky.title, timezone: searchSky.timezone, location: searchSky.location)
        sky.fetchData()
        withAnimation {
            model.tappedSky = nil
        }
    }
}

struct NewSkyView_Previews: PreviewProvider {
    static var previews: some View {
        NewSkyView(searchSky: .init(
            title: "New York",
            location: .init(latitude: 40.7831, longitude: -73.9712),
            timezone: TimeZone(identifier: "America/New_York")!))
    }
}
