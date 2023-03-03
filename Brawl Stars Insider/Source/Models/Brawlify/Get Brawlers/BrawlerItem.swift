//
//  Item.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 17/02/2023.
//

import Foundation

extension Brawler {
    struct Item: Codable {
        let id: Int
        let name: String
        let path: String
        let version: Int
        let description: String
        let descriptionHtml: String
        let imageUrl: URL
        let released: Bool
    }
}
