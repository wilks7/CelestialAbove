//
//  TimeView.swift
//  SwiftAAScene
//
//  Created by Michael Wilkowski on 9/3/23.
//

import SwiftUI
import SceneKit


struct TimeControl: View {
    @State private var showTimeControl = false
    @Binding var time: Date
    
    @State private var initialDay: Date = .now
//    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Group {
            if showTimeControl {
                VStack(spacing: 0){
                    Text(time.formatted(date: .abbreviated, time: .standard) )
                        .foregroundStyle(.white)
                        .padding()

                    DateTapperView(time: $time, initialDay: $initialDay)
                    TimeSlider(time: $time)
                }
            } else {
                Text(time.formatted(date: .omitted, time: .standard))
                    
            }
        }
        .padding()
        .transparent(cornderRadius: 16)
        .onTapGesture {
            self.showTimeControl.toggle()
        }
//        .onReceive(timer) { _ in
//            var _time = time
//            _time = Calendar.current.date(byAdding: .second, value: 1, to: _time) ?? _time
//            self.time = _time
//        }
        

    }
}



#Preview {
    Color.red.ignoresSafeArea()
}
