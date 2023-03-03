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
    var task: Task {
        .requestPlain
    }
    
    var validationType: ValidationType {
        .successCodes
    }
    
    var headers: [String : String]? {
        [
            "Accept-Language" : Locale.preferredLanguages[0],
            "Content-type": "application/json",
            "accept" : "application/json",
        ]
        .compactMapValues { $0 }
    }
}
