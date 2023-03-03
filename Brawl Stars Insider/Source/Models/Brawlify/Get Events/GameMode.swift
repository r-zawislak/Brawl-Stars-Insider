//
//  GameMode.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Foundation

extension Event.Map {
    struct GameMode: Codable {
        let id: Int
        let name: String
        let hash: String
        let version: Int
        let color: String
        let bgColor: String
        let link: URL
        let imageUrl: URL
    }
    
}
