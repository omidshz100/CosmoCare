//
//  ex-DateComponents.swift
//  CosmoCare
//
//  Created by Omid Shojaeian Zanjani on 10/06/23.
//

import Foundation


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
