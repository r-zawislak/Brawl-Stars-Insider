//
//  Data.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Foundation

extension Data {
    var formattedJSONString: String {
        guard
            let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        else {
            return ""
        }
        
        return String(decoding: jsonData, as: UTF8.self)
    }
}
