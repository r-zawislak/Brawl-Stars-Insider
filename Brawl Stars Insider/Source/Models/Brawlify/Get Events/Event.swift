//
//  Event.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Foundation

struct Event: Codable, Identifiable {
    let predicted: Bool
    let startTime: Date
    let endTime: Date
    let reward: Int
    let map: Map
    let slot: Slot
    
    var id: Int {
        slot.id
    }
}
