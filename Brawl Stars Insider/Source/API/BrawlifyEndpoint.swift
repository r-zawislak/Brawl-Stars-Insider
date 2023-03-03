//
//  BrawlifyEndpoint.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Moya
import Foundation

enum BrawlifyEndpoint: Endpoint {
    case getIcons
    case getEvents
    case getBrawlers
    
    var baseURL: URL {
        URL(string: "https://api.brawlapi.com/v1")!
    }
    
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
    
    var method: Moya.Method {
        .get
    }
}
