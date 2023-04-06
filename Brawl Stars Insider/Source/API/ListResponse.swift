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

struct FailableDecodingListResponse<T: Codable>: Codable {
    let list: [T]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var nestedContainer = try container.nestedUnkeyedContainer(forKey: .list)
        
        var decodedList = [T]()
        
        while !nestedContainer.isAtEnd {
            if let item = try? nestedContainer.decode(T.self) {
                decodedList.append(item)
            } else {
                // Skip to next element
                _ = try? nestedContainer.decode(Empty.self)
            }

        }

        self.list = decodedList
    }
}

private struct Empty: Codable { }
