//
//  TimeInterval.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 03/04/2023.
//

import Foundation

extension TimeInterval {
    static func days(_ days: Double) -> TimeInterval {
        let secondsPerDay: TimeInterval = 86400
        return secondsPerDay * days
    }
}
