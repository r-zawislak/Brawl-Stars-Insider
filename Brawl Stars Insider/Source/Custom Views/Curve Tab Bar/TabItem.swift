//
//  TabItem.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 03/03/2023.
//

import Foundation
import SwiftUI

enum TabItem: Int, CaseIterable {
    case events
    case maps
    case brawlers
    case settings
    
    var image: Image {
        switch self {
        case .events:
            return Image(systemName: "calendar")
        case .brawlers:
            return Image(systemName: "person.3.sequence")
        case .maps:
            return Image(systemName: "map")
        case .settings:
            return Image(systemName: "gearshape")
        }
    }
    
    var title: String {
        let localizations = Localizations.TabItems.self
        switch self {
        case .events:
            return localizations.Events.localized
        case .brawlers:
            return localizations.Brawlers.localized
        case .maps:
            return localizations.Maps.localized
        case .settings:
            return localizations.Settings.localized
        }
    }
}
