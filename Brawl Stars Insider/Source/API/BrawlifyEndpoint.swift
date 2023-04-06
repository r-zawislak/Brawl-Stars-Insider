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
    case getBrawler(id: Int)
    case getAllBrawlers
    case getMaps
    
    var path: String {
        switch self {
        case .getIcons:
            return "/icons"
        case .getEvents:
            return "/events"
        case .getBrawler(let id):
            return "/brawlers/\(id)"
        case .getAllBrawlers:
            return "/brawlers"
        case .getMaps:
            return "/maps"
        }
    }
    
    // TODO: Sourcery would be nice for mocks
    var mockData: Data? {
        switch self {
        case .getMaps:
            let maps: [Event.Map] = [.mock, .mock, .mock]
            let listResponse = ListResponse(list: maps)
            return try? JSONEncoder().encode(listResponse)
        default:
            return nil
        }
    }
}
