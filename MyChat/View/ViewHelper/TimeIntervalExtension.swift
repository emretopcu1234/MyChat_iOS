//
//  TimeIntervalExtension.swift
//  MyChat
//
//  Created by Emre Topçu on 11.02.2022.
//

import Foundation

extension TimeInterval {
    func stringFormattedLastSeen() -> String {
        if self == 2147483647 {
            return "online"
        }
        if self == 0 {
            return ""
        }
        let date = Date.init(timeIntervalSince1970: self)
        if Calendar.current.isDateInToday(date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return "last seen today at \(dateFormatter.string(from: date))"
        }
        else if Calendar.current.isDateInYesterday(date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return "last seen yesterday at \(dateFormatter.string(from: date))"
        }
        else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return "last seen \(dateFormatter.string(from: date))"
        }
    }
    
    func stringFormattedLastMessageTime() -> String {
        let date = Date.init(timeIntervalSince1970: self)
        if Calendar.current.isDateInToday(date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return "\(dateFormatter.string(from: date))"
        }
        else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        }
        else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return "\(dateFormatter.string(from: date))"
        }
    }
    
    func stringFormattedMessageDay() -> String {
        let date = Date.init(timeIntervalSince1970: self)
        if Calendar.current.isDateInToday(date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return "Today"
        }
        else if Calendar.current.isDateInYesterday(date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return "Yesterday"
        }
        else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return "\(dateFormatter.string(from: date))"
        }
    }
    
    func stringFormattedMessageHour() -> String {
        let date = Date.init(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return "\(dateFormatter.string(from: date))"
    }
    
    func stringFormattedDefault() -> String {
        let date = Date.init(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm:ss a"
        return "\(dateFormatter.string(from: date))"
    }
}
