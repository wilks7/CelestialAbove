//
//  BackGroundView.swift
//  SkyAbove
//
//  Created by Michael on 8/19/22.
//

import SwiftUI
import WeatherKit


struct BackGroundView: View {
    @ObservedObject var model: BackGroundViewModel
    var colors: [Color] { model.colors }
    
    init(sun: SunEvents?, timezone: TimeZone, time: Date, showClouds: Bool = false) {
        self._model = ObservedObject(wrappedValue: BackGroundViewModel(sun: sun, timezone: timezone, time: time))
        self.showClouds = showClouds
    }
    
    init(colors: [Color], showClouds: Bool = false) {
        self._model = ObservedObject(wrappedValue: BackGroundViewModel(colors: colors))
        self.showClouds = showClouds
    }

    let showClouds: Bool
    var showStars: Bool {showClouds}
    
    var starOpacity: Double {
        let color = starStops.interpolated(amount: 0.5)
        return color.getComponents().alpha
    }
    
    var body: some View {
        ZStack {
            if showStars {
                StarsView()
                    .opacity(starOpacity)
            }
            if showClouds {
                let clouds = 0.5
                let thickness = CloudSize.Thickness.from(clouds)

                CloudsView(thickness: thickness,
                           topTint: cloudTopStops.interpolated(amount: clouds),
                           bottomTint: cloudBottomStops.interpolated(amount: clouds)
                    )
            }
            if !showStars && !showClouds {
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                    }
                }
            }
        }
        .ignoresSafeArea()
        .background(
            AnimatedGradientBackground(initial: colors, colors: $model.colors)
        )
//        .onChange(of: time) { newValue in
//            model.changeColor(date: newValue)
//        }
//        .onAppear{
//            printSun(sunEvents)
//        }
    }
}

extension BackGroundView {
    var cloudTopStops: [Gradient.Stop] { [
        .init(color: .darkCloudStart, location: 0),
        .init(color: .darkCloudStart, location: 0.25),
        .init(color: .sunriseCloudStart, location: 0.33),
        .init(color: .lightCloudStart, location: 0.38),
        .init(color: .lightCloudStart, location: 0.7),
        .init(color: .sunsetCloudStart, location: 0.78),
        .init(color: .darkCloudStart, location: 0.82),
        .init(color: .darkCloudStart, location: 1)
    ] }

    var cloudBottomStops: [Gradient.Stop] { [
        .init(color: .darkCloudEnd, location: 0),
        .init(color: .darkCloudEnd, location: 0.25),
        .init(color: .sunriseCloudEnd, location: 0.33),
        .init(color: .lightCloudEnd, location: 0.38),
        .init(color: .lightCloudEnd, location: 0.7),
        .init(color: .sunsetCloudEnd, location: 0.78),
        .init(color: .darkCloudEnd, location: 0.82),
        .init(color: .darkCloudEnd, location: 1)
    ] }


    var starStops: [Gradient.Stop] { [
        .init(color: .white, location: 0),
        .init(color: .white, location: 0.25),
        .init(color: .clear, location: 0.33),
        .init(color: .clear, location: 0.38),
        .init(color: .clear, location: 0.7),
        .init(color: .clear, location: 0.78),
        .init(color: .white, location: 0.82),
        .init(color: .white, location: 1)
    ] }
}


struct SkyBackgroundGradient: View {
    let time: Date

    let sunEvents: SunEvents?
    var timezone: TimeZone
    var colorValue: Double { time.percent(timezone) }

    var body: some View {
        LinearGradient(colors: [
            backgroundTopStops.interpolated(amount: colorValue),
            backgroundBottomStops.interpolated(amount: colorValue)
        ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

extension SkyBackgroundGradient {

    var astronomicalDawn: Double { sunEvents?.astronomicalDawn?.percent(timezone) ?? 0 }
    var nauticalDawn: Double { sunEvents?.nauticalDawn?.percent(timezone) ?? 0.25 }
    var civilDawn: Double { sunEvents?.civilDawn?.percent(timezone) ?? 0.33 }
    var sunrise: Double { sunEvents?.sunrise?.percent(timezone) ?? 0.48 }
    var solarNoon: Double { sunEvents?.solarNoon?.percent(timezone) ?? 0.59 }
    var sunset: Double { sunEvents?.sunset?.percent(timezone) ?? 0.65 }
    var civilDusk: Double { sunEvents?.civilDusk?.percent(timezone) ?? 0.78 }
    var nauticalDusk: Double { sunEvents?.nauticalDusk?.percent(timezone) ?? 0.85 }
    var astronomicalDusk: Double { sunEvents?.astronomicalDusk?.percent(timezone) ?? 0.95 }
    var solarMidnight: Double { sunEvents?.astronomicalDusk?.percent(timezone) ?? 1 }
}
extension SkyBackgroundGradient {

    var backgroundTopStops: [Gradient.Stop] { [
        .init(color: .midnightStart, location: 0),
        .init(color: .midnightStart, location: astronomicalDawn),
        .init(color: .sunriseStart, location: nauticalDawn),
        .init(color: .sunriseStart, location: civilDawn),
        .init(color: .sunriseStart, location: sunrise),
        .init(color: .sunnyDayStart, location: solarNoon),
        .init(color: .sunsetStart, location: sunset),
        .init(color: .sunsetStart, location: civilDusk),
        .init(color: .sunsetStart, location: nauticalDusk),
        .init(color: .midnightStart, location: astronomicalDusk),
        .init(color: .midnightStart, location: solarMidnight),
        .init(color: .midnightStart, location: 1)

    ] }

    var backgroundBottomStops: [Gradient.Stop] { [
        .init(color: .midnightEnd, location: 0),
        .init(color: .midnightEnd, location: astronomicalDawn),
        .init(color: .sunriseEnd, location: nauticalDawn),
        .init(color: .sunriseEnd, location: civilDawn),
        .init(color: .sunriseEnd, location: sunrise),
        .init(color: .sunnyDayEnd, location: solarNoon),
        .init(color: .sunsetEnd, location: sunset),
        .init(color: .sunsetEnd, location: civilDusk),
        .init(color: .sunsetEnd, location: nauticalDusk),
        .init(color: .midnightEnd, location: astronomicalDusk),
        .init(color: .midnightEnd, location: solarMidnight),
        .init(color: .midnightEnd, location: 1)
    ] }


}

//struct BackGroundView_Previews: PreviewProvider {
//    @State static var time = Date.now.percent
//    static var previews: some View {
//        BackGroundView(time: $time, skyID: sky.id, forecast: sky.forecasts)
//    }
//}

//extension BackGroundView {
//    func printSun(_ sun: SunEvents?){
//        print(sky?.title ?? "Sky")
//        guard let sun else {return}
//        print("\n\n")
//        print("-----------------------------")
//        print("Astronomical Dawn: " + astronomicalDawn.double + " - " + (sun.astronomicalDawn?.time(timezone) ?? "none"))
//        print("Nautical Dawn: " + nauticalDawn.double + " - " + (sun.nauticalDawn?.time(timezone) ?? "none"))
//        print("Civil Dawn: " + civilDawn.double + " - " + (sun.civilDawn?.time(timezone) ?? "none"))
//        print("Sunrise: " + sunrise.double + " - " + (sun.sunrise?.time(timezone) ?? "none"))
//        print("Solar Noon: " + solarNoon.double + " - " + (sun.solarNoon?.time(timezone) ?? "none"))
//        print("Sunset: " + sunset.double + " - " + (sun.sunset?.time(timezone) ?? "none"))
//        print("Civil Dusk: " + civilDusk.double + " - " + (sun.civilDusk?.time(timezone) ?? "none"))
//        print("Nautical Dusk: " + nauticalDusk.double + " - " + (sun.nauticalDusk?.time(timezone) ?? "none"))
//        print("Astronomical Dusk: " + astronomicalDusk.double + " - " + (sun.astronomicalDusk?.time(timezone) ?? "none"))
//        print("Solar Midnight: " + solarMidnight.double + " - " + (sun.solarMidnight?.time(timezone) ?? "none"))
//        print("-----------------------------")
//    }
//}
