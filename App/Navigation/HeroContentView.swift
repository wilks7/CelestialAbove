//
//  HeroContentView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import SwiftData
import WeatherKit

struct HeroContentView: View {
    @Namespace private var animationNamespace
    @Query private var skies: [Sky]
    
    private let service = WeatherService()
    
    @State private var selected: Sky? = nil
    var body: some View {
        ZStack {
            if selected == nil {
                SkiesListView(skies: skies, selected: $selected, animationNamespace: animationNamespace)
            }
            if let sky = selected {
                Group {
                    #if !os(watchOS)
                    SkiesTabView(selected: sky, dismissSky: $selected, animationNamespace: animationNamespace)
                    #endif
                }

            }
        }
        .clipped(antialiased: false)
        .task {
            await fetchAllWeatherUsingTaskGroup()
        }
//        .onAppear {
//            for sky in skies {
//                Task {@MainActor in
//                    let weather = try await service.fetchWeather(for: sky)
//                    sky.weather = weather
//                }
//            }
//        }
    }
    
    func fetchAllWeatherUsingTaskGroup() async {
        print("FETCHING ALL WEATHER")
        await withTaskGroup(of: Void.self) { group in
            for sky in skies {
                group.addTask {
                    do {
                        sky.color = .random()
                        let weather = try await service.fetchWeather(for: sky)
                        sky.weather = weather
                    } catch {
                        // Handle the error, perhaps by logging it or setting an error state in your view model
                        print("Error fetching weather for \(sky): \(error)")
                    }
                }
            }

            // Wait for all tasks to complete
            for await _ in group { }
        }
    }
}

#Preview {
    HeroContentView()
        .modelContainer(previewContainer)
}
