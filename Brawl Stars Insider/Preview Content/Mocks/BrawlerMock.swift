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
            link: .mock,
            imageUrl: .mock,
            imageUrl2: .mock,
            imageUrl3: .mock,
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
            imageUrl: .mock,
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
