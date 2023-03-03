//
//  Event.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Foundation

extension Event {
    struct Map: Codable {
        let id: Int
        let new: Bool
        let disabled: Bool
        let name: String
        let hash: String
        let version: Int
        let link: URL
        let imageUrl: URL
        let credit: String?
        let stats: [Stat]
        let environment: Environment
        let gameMode: GameMode
    }
}
