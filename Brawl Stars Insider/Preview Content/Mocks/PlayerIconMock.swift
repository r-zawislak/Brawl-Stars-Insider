//
//  PlayerIconMock.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 31/03/2023.
//

extension PlayerIcon {
    static var mock: Self {
        PlayerIcon(
            id: .random(in: 1...60),
            name: .random(),
            name2: .random(),
            imageUrl: .mock,
            imageUrl2: .mock,
            brawler: .randomBrawlerId,
            requiredExpLevel: 0,
            requiredTotalTrophies: 0,
            sortOrder: 0,
            isReward: .random(),
            isAvailableForOffers: .random()
        )
    }
}
