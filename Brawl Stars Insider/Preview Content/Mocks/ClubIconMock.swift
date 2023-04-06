//
//  ClubIconMock.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 31/03/2023.
//

import Foundation

extension ClubIcon {
    static var mock: Self {
        ClubIcon(id: .random(in: 0...100), imageUrl: .mock)
    }
}
