//
//  PlayerIcon.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Foundation

struct PlayerIcon: Codable {
    let id: Int
    let name: String
    let name2: String
    let imageUrl: URL
    let imageUrl2: URL
    let brawler: Int?
    let requiredExpLevel: Int
    let requiredTotalTrophies: Int
    let sortOrder: Int
    let isReward: Bool
    let isAvailableForOffers: Bool
}

extension PlayerIcon: Comparable {
    static func < (lhs: PlayerIcon, rhs: PlayerIcon) -> Bool {
        lhs.sortOrder < rhs.sortOrder
    }
}
