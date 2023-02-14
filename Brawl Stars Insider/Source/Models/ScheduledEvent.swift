//
//  ScheduledEvent.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Foundation

struct ScheduledEvent: Codable {
    let startTime: Date
    let endTime: Date
    let slotId: Int
    let event: Event
}
