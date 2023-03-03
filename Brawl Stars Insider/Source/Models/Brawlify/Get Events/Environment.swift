//
//  Environment.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Foundation

extension Event.Map {
    struct Environment: Codable {
        let id: Int
        let name: String
        let hash: String
        let path: String
        let version: Int
        let imageUrl: URL
    }
}
