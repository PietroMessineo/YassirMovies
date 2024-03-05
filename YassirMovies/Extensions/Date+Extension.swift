//
//  Date+Extension.swift
//  YassirMovies
//
//  Created by Pietro Messineo on 05/03/24.
//

import Foundation

extension Date {
    func getReleaseStatus() -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        
        if calendar.isDate(self, inSameDayAs: currentDate) || self < currentDate {
            return "Released"
        } else {
            let dateComponents = calendar.dateComponents([.day], from: currentDate, to: self)
            let daysLeft = dateComponents.day ?? 0
            if daysLeft == 0 {
                return "Today"
            } else {
                let dayKey = daysLeft != 1 ? "%d days" : "%d day"
                return String(format: dayKey, daysLeft)
            }
        }
    }
    
    func todaysFormattedDate() -> String {
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateFormatted = newDateFormatter.string(from: self)
        return currentDateFormatted
    }
    
    func nextYearFormattedDate() -> String {
        let newDateFormatter = DateFormatter()
        var dateComponent = DateComponents()
        dateComponent.year = 1
        let oneYearLater = Calendar.current.date(byAdding: dateComponent, to: self)
        let oneYearLaterFormatted = newDateFormatter.string(from: oneYearLater!)
        return oneYearLaterFormatted
    }
}
