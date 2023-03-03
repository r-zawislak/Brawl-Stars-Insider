//
//  Brawler.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 17/02/2023.
//

import Foundation

// TODO: Better property names, like emojiImageURL for imageUrl3 and so on...
struct Brawler: Codable {
    let id: Int
    let avatarId: Int
    let name: String
    let hash: String
    let path: String
    let released: Bool
    let version: Int
    let link: URL
    let imageUrl: URL
    let imageUrl2: URL
    let imageUrl3: URL
    let description: String
    let descriptionHtml: String
    
    let rarity: Rarity
    let `class`: Class
    let gadgets: [Item]
    let starPowers: [Item]
//    let unlock: String?
//    let videos: [String]?
}
