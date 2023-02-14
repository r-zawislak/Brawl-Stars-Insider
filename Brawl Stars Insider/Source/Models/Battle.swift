//
//  Battle.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Foundation

struct Battle: Codable {
    let mode: EventMode
    let type: BattleType
    let rank: Int?
    let result: BattleResult?
    let trophyChange: Int
    let players: [Player]
    let starPlayer: Player?
}
