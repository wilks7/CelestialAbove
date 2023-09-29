//
//  AnimatedGradientBackground.swift
//  SkyAbove
//
//  Created by Michael Wilkowski on 3/12/23.
//

import SwiftUI
import WeatherKit

struct AnimatedGradientBackground: View {
    @State var initial: [Color]

    @State private var gradientB: [Color] = [.red, .purple]
    
    @State private var firstPlane: Bool = true
    
    @Binding var colors: [Color]
    

    func setGradient(gradient: [Color]) {
        if firstPlane {
            gradientB = gradient
        }
        else {
            initial = gradient
        }
        firstPlane = !firstPlane
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: self.initial, startPoint: .top, endPoint: .bottom)
//            RoundedRectangle(cornerRadius: 8)
//                .fill(LinearGradient(gradient: Gradient(colors: self.initial), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1)))
            LinearGradient(colors: self.gradientB, startPoint: .top, endPoint: .bottom)
                .opacity(self.firstPlane ? 0 : 1)

//            RoundedRectangle(cornerRadius: 8)
//                .fill(LinearGradient(gradient: Gradient(colors: self.gradientB), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1)))
//                .opacity(self.firstPlane ? 0 : 1)
        }
        .ignoresSafeArea()
//        .frame(width: 256, height: 256)
        .onChange(of: colors, perform: { newValue in
            withAnimation(.spring()) {
                self.setGradient(gradient: newValue)
//                                    [
//                                    backgroundTopStops.interpolated(amount: colorValue),
//                                    backgroundBottomStops.interpolated(amount: colorValue)
//                                    ]
//                self.setGradient(gradient: newValue)
            }
        })

    }
}


//struct AnimatedGradientBackground_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimatedGradientBackground(initial: Color.colors(for: sunEvents, timezone: sky.timezone), colors: .constant([.red, .blue]))
//    }
//}
