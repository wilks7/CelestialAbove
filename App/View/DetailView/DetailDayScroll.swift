//
//  DetailDayScroll.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import WeatherKit

extension DayWeather: Identifiable {
    public var id: Date { date }
}

struct DetailDayScroll: View {
    let daily: [DayWeather]
    @Binding var selectedDay: DayWeather?
    
    let weekFormatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "EEEE"
        return fmt
    }()
    
    func weekday(_ day: DayWeather) -> String {
        weekFormatter.string(from: day.date).prefix(1).uppercased()
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(daily){ day in
                    VStack {
                        Text(weekday(day))
//                        ZStack {
//                            Circle().fill(.indigo).frame(width: 25, height: 25)
//                                .opacity(day == selectedDay ? 1:0)
                            Text(monthday(day))
                                .foregroundColor(textColor(day))
                                .padding()
                                .background(day == selectedDay ? .indigo : .clear )
                                .clipShape(Circle())
//                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedDay = day
                        }
                    }
                    .font(.title3)
                }
            }
        }
    }
    

    
    
    func textColor(_ day: DayWeather) -> SwiftUI.Color {
        let isToday = Calendar.current.isDateInToday(day.date)
        let color: Color = isToday ? .indigo : .white
        return selectedDay == day ? .black:color
    }

    
    func monthday(_ day: DayWeather)->String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: day.date)
        return String(day)
    }
    
}

//struct DetailDayScroll_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailDayScroll()
//    }
//}
