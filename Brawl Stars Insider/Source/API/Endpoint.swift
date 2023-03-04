//
//  Endpoint.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Alamofire
import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var mockData: Data? { get }
}

extension Endpoint {
    var parameters: Parameters? {
        nil
    }
    
    var baseURL: URL {
        URL(string: "https://api.brawlapi.com/v1")!
    }
    
    var method: HTTPMethod {
        .get
    }

    var headers: HTTPHeaders? {
        HTTPHeaders([
            "Accept-Language" : Locale.preferredLanguages[0],
            "Content-type": "application/json",
            "accept" : "application/json",
        ])
    }
}
