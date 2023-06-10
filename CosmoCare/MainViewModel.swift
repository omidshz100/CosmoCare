//
//  MainViewModel.swift
//  CosmoCare
//
//  Created by Omid Shojaeian Zanjani on 10/06/23.
//

import Foundation


class MainViewModel:ObservableObject{
    struct DaysWeek:Identifiable, Hashable{
        let id:UUID = UUID()
        var date:Date!
        var component:DateComponents!
    }
    func weekDaysGenerator(date:Date) -> [DaysWeek]{
        let calCurrent = Calendar.current
        var weedDates:[DaysWeek] = []
        for i in 0..<7 {
            let weekDayToday = calCurrent.dateComponents([.weekday], from: date)
            guard let weekDay = weekDayToday.weekday else {
                print("day not found")
                return []
            }
            var compDate = DateComponents()
            compDate.day = (i + 1) - weekDay
            let data = DaysWeek(date: calCurrent.date(byAdding: compDate, to: date)!, component: calCurrent.date(byAdding: compDate, to: date)!.component)
            weedDates.append(data)
        }
        return weedDates
    }
}
