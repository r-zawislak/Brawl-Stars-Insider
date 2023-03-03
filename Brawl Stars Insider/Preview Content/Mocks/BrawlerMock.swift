//
//  BrawlerMock.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 17/02/2023.
//

import Foundation

extension Brawler {
    static var mock: Self {
        Self(
            id: .randomBrawlerId,
            avatarId: 28000184,
            name: .random(),
            hash: .random(),
            path: .random(),
            released: .random(),
            version: 1,
            link: URL(string: "https://cdn-old.brawlify.com/brawler-bs/Mandy.png")!,
            imageUrl: URL(string: "https://cdn-old.brawlify.com/brawler-bs/Mandy.png")!,
            imageUrl2: URL(string: "https://cdn-old.brawlify.com/brawler-bs/Mandy.png")!,
            imageUrl3: URL(string: "https://cdn-old.brawlify.com/brawler-bs/Mandy.png")!,
            description: .random(),
            descriptionHtml: .random(),
            rarity: .mock,
            class: .mock,
            gadgets: [.mock, .mock],
            starPowers: [.mock, .mock]
        )
    }
}

extension Brawler.Item {
    static var mock: Self {
        Self(
            id: 23000543,
            name: .random(),
            path: .random(),
            version: 1,
            description: .random(),
            descriptionHtml: .random(),
            imageUrl: URL(string: "https://cdn-old.brawlify.com/star-powers/Full.png")!,
            released: .random()
        )
    }
}

extension Brawler.Rarity {
    static var mock: Self {
        Self(id: .random(in: 0...5), name: .random(), color: "#ff00ff")
    }
}

extension Brawler.Class {
    static var mock: Self {
        Self(id: .random(in: 0...3), name: .random())
    }
}
