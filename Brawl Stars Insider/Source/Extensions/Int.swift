//
//  Int.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 17/02/2023.
//

import Foundation

extension Int {
    static var randomBrawlerId: Int {
        random(in: 16000000...16000064)
    }
}
