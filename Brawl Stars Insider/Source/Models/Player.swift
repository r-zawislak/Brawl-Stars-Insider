//
//  Player.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Foundation

struct Player: Codable {
    let tag: String
    let name: String
    let brawler: PlayerBrawler
}
