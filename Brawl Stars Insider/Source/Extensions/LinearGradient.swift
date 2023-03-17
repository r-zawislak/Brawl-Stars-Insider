//
//  LinearGradient.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 17/03/2023.
//

import SwiftUI

extension LinearGradient {
    static var chromatic: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.purple, .red, .yellow]), startPoint: .leading, endPoint: .trailing)
    }
}
