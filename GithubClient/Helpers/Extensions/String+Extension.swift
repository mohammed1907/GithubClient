//
//  String+Extension.swift
//  GithubClient
//
//  Created by Farghaly on 17/11/2021.
//

import Foundation

extension String {

    var formatedShortDate: String {
        var dateString = self
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let date = formatter.date(from: dateString) {
                let difference = NSDate().timeIntervalSince(date as Date)

                let years = Int(difference) / 31104000
                let month = Int(difference) / 2592000

                if abs(years) > 0 {
                    return "\(abs(years)) years ago"
                } else if abs(month) > 6 {
                    return "\(abs(month)) month ago"
                }

            formatter.dateFormat = "EEEE, MMM d, yyyy"
            let outputDate = formatter.string(from: date)
            dateString = outputDate
        }
        return dateString
    }
}
