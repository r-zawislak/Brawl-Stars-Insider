//
//  GetEventsResponse.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Foundation

struct GetEventsResponse: Codable {
    let active: [Event]
    let upcoming: [Event]
}
