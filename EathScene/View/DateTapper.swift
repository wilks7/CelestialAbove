//
//  DateTapper.swift
//  SwiftAAScene
//
//  Created by Michael Wilkowski on 9/3/23.
//

import SwiftUI

struct DateTapperView: View {
    @Binding var time: Date
    @Binding var initialDay: Date

    var body: some View {
        Grid {
            GridRow {
                Button {
                    let newDate = Calendar.current.date(byAdding: .day, value: -1, to: time)!
                    self.time = newDate
                    self.initialDay = Calendar.current.startOfDay(for: newDate)
                } label: {
                    Image(systemName: "minus")
                }
                Button {
                    self.time = Date.now
                } label: {
                    Image(systemName: "clock")
                }
                Button {
                    let newDate = Calendar.current.date(byAdding: .day, value: 1, to: time)!
                    self.time = newDate
                    self.initialDay = Calendar.current.startOfDay(for: newDate)
                } label: {
                    Image(systemName: "plus")
                }
            }
            .font(.title3)
            .bold()
            .foregroundStyle(.blue)
        }
    }
}


#Preview {
    @State var time: Date = .now
    @State var initialDay: Date = .now
    return DateTapperView(time: $time, initialDay: $initialDay)
//    DateTapper(time: .c)
}
