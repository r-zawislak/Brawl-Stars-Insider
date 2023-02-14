//
//  BrawlStarsEndpoint.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Moya

enum BrawlStarsEndpoint: Endpoint {
    case getBattleLog(playerTag: String)
    case getPlayerInfo(playerTag: String)
    
    case getSeasons
    case getRankings(seasonId: Int)
    case getBrawlerRankings(id: Int)
    
    case getEventsRotation
    
    case getBrawlers
    case getBrawlerInfo(id: Int)
    
    var path: String {
        switch self {
        case .getBattleLog(let playerTag):
            return "/players/\(playerTag)/battlelog"
        case .getPlayerInfo(let playerTag):
            return "/players/\(playerTag)"
        case .getSeasons:
            return "/rankings/global/powerplay/seasons"
        case .getRankings(let seasonId):
            return "/rankings/global/powerplay/seasons/\(seasonId)"
        case .getBrawlerRankings(let id):
            return "/rankings/global/brawlers/\(id)"
        case .getBrawlers:
            return "/brawlers"
        case .getBrawlerInfo(let id):
            return "/brawlers/\(id)"
        case .getEventsRotation:
            return "/events/rotation"
        }
    }
    
    var method: Moya.Method {
        .get
    }
}
