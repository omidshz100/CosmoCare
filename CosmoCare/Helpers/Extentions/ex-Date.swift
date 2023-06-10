//
//  Extention.swift
//  CosmoCare
//
//  Created by Omid Shojaeian Zanjani on 10/06/23.
//
//
import Foundation


extension Date {
    func getComponent(calendar:Calendar)->DateComponents {
        return calendar.dateComponents([.weekday, .day, .month, .year, .hour, .minute, .second], from: self)
    }
    func getComponent()->DateComponents {
        return Calendar.current.dateComponents([.weekday, .day, .month, .year, .hour, .minute, .second], from: self)
    }
    var component:DateComponents{
        return Calendar.current.dateComponents([.weekday, .day, .month, .year, .hour, .minute, .second], from: self)
    }
}
