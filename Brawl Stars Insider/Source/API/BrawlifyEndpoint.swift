//
//  BrawlifyEndpoint.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Foundation
import Alamofire

enum BrawlifyEndpoint: Endpoint {
    case getIcons
    case getEvents
    case getBrawlers
    
    var path: String {
        switch self {
        case .getIcons:
            return "/icons"
        case .getEvents:
            return "/events"
        case .getBrawlers:
            return "/brawlers"
        }
    }
    
    // TODO: Sourcery would be nice for mocks
    var mockData: Data? {
        nil
    }
}
