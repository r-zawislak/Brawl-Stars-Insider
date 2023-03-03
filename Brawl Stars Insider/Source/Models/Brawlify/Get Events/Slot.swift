//
//  Slot.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Foundation

extension Event {
    struct Slot: Codable {
        let id: Int
        let name: String
        let emoji: String
        let hash: String
        let listAlone: Bool
        let hideable: Bool
        let hideForSlot: Int?
        let background: URL?
    }
}
