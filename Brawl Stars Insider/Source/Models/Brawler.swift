//
//  Brawler.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Foundation

struct Brawler: Codable {
    let id: String
    let name: String
    let starPowers: [Item]
    let gadgets: [Item]
}
