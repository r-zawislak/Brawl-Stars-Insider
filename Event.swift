//
//  Event.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Foundation

struct Event: Codable {
    let id: Int
    let mode: EventMode
    let map: String
    let modifiers: [Modifier]?
}
