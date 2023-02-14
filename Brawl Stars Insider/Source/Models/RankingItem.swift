//
//  RankingItem.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Foundation

struct RankingItem: Codable {
    let tag: String
    let name: String
    let nameColor: String
    let trophies: Int
    let rank: Int
    let icon: Icon
    let club: Club
}
