//
//  BattleLog.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Foundation

struct BattleLog: Codable {
    let battleTime: Date
    let event: Event
    let battle: Battle
}
