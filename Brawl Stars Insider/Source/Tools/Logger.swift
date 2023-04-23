//
//  Logger.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Foundation
import Alamofire

enum LogType {
    case request
    case response
    case error
    case `default`
    
    var prefix: String {
        switch self {
        case .request:
            return "🟡 [REQUEST]"
        case .response:
            return "🟢 [RESPONSE]"
        case .error:
            return "⛔️ [ERROR]"
        case .default:
            return "⚪️ [LOG]"
        }
    }
}

final class Logger {
    func log(_ message: Any, logType: LogType = .default) {
    #if DEBUG
        print("\(logType.prefix) \(message)")
    #endif
    }
    
    func log(_ message: Error?) {
        guard let error = message else {
            return
        }
        
        log(error, logType: .error)
    }
}

// MARK: - EventMonitor

extension Logger: EventMonitor {
    
    func requestDidResume(_ request: Request) {
        requestItems(request: request).forEach {
            log($0, logType: .request)
        }
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        successResponseItems(response: response).forEach {
            log($0, logType: .response)
        }
    }

    private func requestItems(request: Request?) -> [String] {
        guard let request = request?.request else {
            return ["Invalid request"]
        }

        let allHeaders = request.allHTTPHeaderFields ?? [:]

        let formattedHeaders = allHeaders.map {
            "\t\($0.key): \($0.value)"
        }
            .joined(separator: "\n")

        return [
            "Method: \(request.httpMethod ?? "No method")",
            "URL: \(request.description)",
            "Headers:\n\(formattedHeaders)",
            "Body:\n\(request.httpBody?.formattedJSONString ?? "\tEmpty")",
        ]
    }

    private func successResponseItems<Value>(response: DataResponse<Value, AFError>) -> [String] {
        return [
            "URL: \(response.response?.url?.absoluteString ?? "No URL")",
            "Body:\n\(response.data?.formattedJSONString ?? "No body")",
        ]
    }
}
