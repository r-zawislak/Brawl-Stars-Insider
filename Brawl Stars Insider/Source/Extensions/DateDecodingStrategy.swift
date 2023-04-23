//
//  DateDecodingStrategy.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 06/09/2023.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {
    static func iso8601(options: ISO8601DateFormatter.Options = []) -> JSONDecoder.DateDecodingStrategy {
        custom {
            let container = try $0.singleValueContainer()
            let string = try container.decode(String.self)
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = options.union([.withFullDate, .withFullTime, .withTimeZone])

            guard let date = formatter.date(from: string) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(string)")
            }
            
            return date
        }
    }
}
