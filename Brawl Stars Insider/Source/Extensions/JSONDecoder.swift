//
//  JSONDecoder.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Foundation

extension JSONDecoder {
    static var brawlifyDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.brawlifyDateFormatter)
        return decoder
    }
}
