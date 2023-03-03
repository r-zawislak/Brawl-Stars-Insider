//
//  ListResponse.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Foundation

struct ListResponse<T: Codable>: Codable {
    let list: [T]
}
