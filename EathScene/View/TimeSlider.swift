//
//  TimeSlider.swift
//  SwiftAAScene
//
//  Created by Michael Wilkowski on 8/31/23.
//

import SwiftUI

struct TimeSlider: View {
    @Binding var time: Date
    var startOfDay: Date {
        Calendar.current.startOfDay(for: time)
    }
    var timeInterval: Binding<TimeInterval> {
        .init {
            time.timeIntervalSince(startOfDay)
        } set: { value in
            time = startOfDay.addingTimeInterval(value)
        }
    }
    
    
    var body: some View {
        VStack {
            Slider(value: timeInterval, in: 0...86340, step: 1) // 0 to 86340 seconds (23 hours)
                .padding()

        }
    }

}


#Preview {
    @State var time = Date.now
    return TimeSlider(time: $time)
}
