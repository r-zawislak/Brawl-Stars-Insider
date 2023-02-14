//
//  ListResponse.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Foundation

struct Paging: Codable {
    let cursors: Cursors
}

struct Cursors: Codable {
    let after: String?
    let before: String?
}

struct ListResponse<T: Codable>: Codable {
    let items: [T]
    let paging: Paging
}
