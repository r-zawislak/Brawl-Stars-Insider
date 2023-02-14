//
//  Endpoint.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Moya
import Foundation

protocol Endpoint: TargetType { }

extension Endpoint {
    var baseURL: URL {
        URL(string: "https://api.brawlstars.com/v1")!
    }
    
    var headers: [String : String]? {
        [
            "Accept-Language" : Locale.preferredLanguages[0],
            "Content-type": "application/json",
            "accept" : "application/json",
            "Authorization" : bearerToken,
        ]
            .compactMapValues { $0 }
    }
    
    var task: HTTPTask {
        .requestPlain
    }
    
    var validationType: ValidationType {
        .successCodes
    }
    
    private var bearerToken: String {
        ""
    }
}
