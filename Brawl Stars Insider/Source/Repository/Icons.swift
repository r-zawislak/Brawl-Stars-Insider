//
//  Icons.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 17/02/2023.
//

import Foundation

struct Icons: Codable {
    var clubIconForId: [String : ClubIcon] = [:]
    var playerIconForId: [String : PlayerIcon] = [:]
    var brawlerForId: [Int : Brawler] = [:]
}
