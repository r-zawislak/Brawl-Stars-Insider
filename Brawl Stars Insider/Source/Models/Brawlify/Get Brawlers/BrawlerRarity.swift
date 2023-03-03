//
//  BrawlerRarity.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 17/02/2023.
//

import Foundation

extension Brawler {
    struct Rarity: Codable {
        let id: Int
        let name: String
        let color: String
    }
}
