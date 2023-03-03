//
//  String.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 17/02/2023.
//

import Foundation

extension String {
    static func random(length: Int = 8) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomStringElements = (0..<length).map { _ in letters.randomElement()! }
        return String(randomStringElements)
    }
}
