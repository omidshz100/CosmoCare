//
//  ex-String.swift
//  CosmoCare
//
//  Created by Omid Shojaeian Zanjani on 10/06/23.
//

import Foundation


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
