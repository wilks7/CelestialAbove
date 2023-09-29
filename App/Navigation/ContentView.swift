////
////  ContentView.swift
////  CelestialAbove
////
////  Created by Michael Wilkowski on 5/11/23.
////
//
//import SwiftUI
//import SwiftData
//import WeatherKit
//
//struct ContentView: View {
//    @Namespace private var animationNamespace
//
//    @Environment(\.horizontalSizeClass) var horizontalSizeClass
//    @Query private var skies: [Sky]
//    
//    private let service = WeatherService()
//    
//    @State private var selected: Sky? = nil
//    var body: some View {
//        NavigationSplitView {
//            SkiesListView(skies: skies, selected: $selected, animationNamespace: animationNamespace)
//            .navigationDestination(item: $selected) { sky in
//                Group {
//                    #if os(iOS)
//                    if horizontalSizeClass == .compact {
//                        SkiesTabView(selected: sky)
//                    } else {
//                        SkyGridView(sky: sky)
//                    }
//                    #else
//                    SkyGridView(sky: sky)
//                    #endif
//                }
//                .background(
//                    sky.color
//
//                )
//                .matchedGeometryEffect(id: sky.id, in: animationNamespace)
//
//            }
//        } detail: {
//            ContentUnavailableView(
//                skies.isEmpty ? "Add a Night Sky" : "Select a Sky",
//                systemImage: "moon.stars"
//            )
//        }
//        .task {
//            await fetchAllWeatherUsingTaskGroup()
//        }
////        .onAppear {
////            for sky in skies {
////                Task {@MainActor in
////                    let weather = try await service.fetchWeather(for: sky)
////                    sky.weather = weather
////                }
////            }
////        }
//    }
//    
//    func fetchAllWeatherUsingTaskGroup() async {
//        print("FETCHING ALL WEATHER")
//        await withTaskGroup(of: Void.self) { group in
//            for sky in skies {
//                group.addTask {
//                    do {
//                        sky.color = .random()
//                        let weather = try await service.fetchWeather(for: sky)
//                        sky.weather = weather
//                    } catch {
//                        // Handle the error, perhaps by logging it or setting an error state in your view model
//                        print("Error fetching weather for \(sky): \(error)")
//                    }
//                }
//            }
//
//            // Wait for all tasks to complete
//            for await _ in group { }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//        .modelContainer(previewContainer)
//}
