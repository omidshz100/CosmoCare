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

extension DateComponents {
    var getDayName: String? {
        let calendar = Calendar.current
        guard let date = calendar.date(from: self) else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // "EEEE" represents the full name of the day (e.g., "Monday")
        
        return dateFormatter.string(from: date)
    }
}


extension String {
    var firstLetter:String {
        if let firstLetter = self.first {
            let firstLetterAsString = String(firstLetter)
            return firstLetterAsString
        }else{
            return ""
        }
    }
}
