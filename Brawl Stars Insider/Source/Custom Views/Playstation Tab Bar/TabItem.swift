//
//  TabItem.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 03/03/2023.
//

import Foundation
import SwiftUI

enum TabItem: CaseIterable {
    case events
    case maps
    case settings
    
    var image: Image {
        switch self {
        case .events:
            return Image("events")
        case .maps:
            return Image("maps")
        case .settings:
            return Image("settings")
        }
    }
    
    var title: String {
        switch self {
        case .events:
            return "Events"
        case .maps:
            return "Maps"
        case .settings:
            return "Settings"
        }
    }
}
