//
//  EventMock.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 17/02/2023.
//

import Foundation

extension Event {
    static var mock: Event {
        Event(
            predicted: .random(),
            startTime: .now,
            endTime: Date().addingTimeInterval(3600),
            reward: .random(in: 0...10),
            map: .mock,
            slot: .mock
        )
    }
}

extension Event.Slot {
    static var mock: Self {
        Self(
            id: .random(in: 0...1000),
            name: .random(),
            emoji: .random(),
            hash: .random(),
            listAlone: .random(),
            hideable: .random(),
            hideForSlot: nil,
            background: nil
        )
    }
}

extension Event.Map {
    static var mock: Self {
        Self(
            id: .random(in: 0...1000),
            new: .random(),
            disabled: .random(),
            name: .random(),
            hash: .random(),
            version: 1,
            link: URL(string: "https://cdn-old.brawlify.com/gamemode/header/Duo-Showdown.png")!,
            imageUrl: URL(string: "https://cdn-old.brawlify.com/map/15000108.png")!,
            credit: nil,
            stats: (0...30).map { _ in Event.Map.Stat.mock },
            environment: .mock,
            gameMode: .mock,
            lastActive: nil
        )
    }
}

extension Event.Map.Stat {
    static var mock: Event.Map.Stat {
        Self.init(brawler: .randomBrawlerId, winRate: .random(in: 0...100), useRate: .random(in: 0...100))
    }
}

extension Event.Map.Environment {
    static var mock: Self {
        Self(
            id: .random(in: 0...1000),
            name: .random(),
            hash: .random(),
            path: .random(),
            version: 1,
            imageUrl: URL(string: "https://cdn-old.brawlify.com/gamemode/header/Duo-Showdown.png")!
        )
    }
}


extension Event.Map.GameMode {
    static var mock: Self {
        Self(
            id: .random(in: 0...1000),
            name: .random(),
            hash: .random(),
            version: 1,
            color: "#ff0000",
            bgColor: "#00ff00",
            link: URL(string: "https://cdn-old.brawlify.com/gamemode/header/Duo-Showdown.png")!,
            imageUrl: URL(string: "https://cdn-old.brawlify.com/gamemode/Duo-Showdown.png")!
        )
    }
}

