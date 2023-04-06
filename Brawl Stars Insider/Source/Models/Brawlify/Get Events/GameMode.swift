//
//  GameMode.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Foundation

extension Event.Map {
    struct GameMode: Codable, Hashable, Identifiable {
        let id: Int
        let name: String
        let hash: String
        let version: Int
        let color: String
        let bgColor: String
        let link: URL
        let imageUrl: URL
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(hash)
        }
    }
}
