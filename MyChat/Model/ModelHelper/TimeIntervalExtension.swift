//
//  TimestampConverter.swift
//  MyChat
//
//  Created by Emre Topçu on 6.02.2022.
//

import Foundation

extension TimeInterval {
    func stringFormattedLastSeen() -> String {
        if self == 2147483647 {
            return "online"
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
}
