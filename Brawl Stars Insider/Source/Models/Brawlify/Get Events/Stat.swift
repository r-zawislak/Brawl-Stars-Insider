//
//  Stat.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Foundation

extension Event.Map {
    struct Stat: Codable, Identifiable {
        let brawler: Int
        let winRate: CGFloat
        let useRate: CGFloat
        
        var id: Int {
            brawler
        }
    }
}
