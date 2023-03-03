//
//  GetIconsResponse.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Foundation

struct GetIconsResponse: Codable {
    let player: [String: PlayerIcon]
    let club: [String: ClubIcon]
}
