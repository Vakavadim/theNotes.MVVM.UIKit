//
//  CalendarHelper.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 25.12.2022.
//

import Foundation

final class CalendarHelper {
    static let shared = CalendarHelper()
    private init() {}
    
    private let calendar = Calendar.current
    
    func weekDayString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.string(from: date)
        return dateFormatter.string(from: date)
    }
    
    func dateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd/MM/YY"
        dateFormatter.string(from: date)
        return dateFormatter.string(from: date)
    }
    
    func weekAgo(date: Date) -> Date {
        guard let weekAgoDate = calendar.date(byAdding: .day, value: -7, to: date) else { return date }
        return weekAgoDate
    }
    
    func getDateString(date: Date) -> String {
        let currentDay = Date()
        let weekAgo = weekAgo(date: currentDay)
        if date > weekAgo {
            return weekDayString(date: date)
        } else {
            return dateString(date: date)
        }
    }
}
