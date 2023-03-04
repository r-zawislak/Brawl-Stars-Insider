//
//  DateFormatter.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Foundation

extension DateFormatter {
    static var brawlifyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        // https://joda-time.sourceforge.net/api-1.3/org/joda/time/format/ISODateTimeFormat.html#basicDateTime()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        return formatter
    }
}
