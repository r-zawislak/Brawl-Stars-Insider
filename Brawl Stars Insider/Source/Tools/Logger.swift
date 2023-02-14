//
//  Logger.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/02/2023.
//

import Moya
import Foundation

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

// MARK: - Moya.PluginType

extension Logger: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        requestItems(requestType: request, target: target).forEach {
            log($0, logType: .request)
        }
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        responseItems(result: result, target: target).forEach {
            log($0, logType: .response)
        }
    }
    
    private func requestItems(requestType: RequestType, target: TargetType) -> [String] {
        guard let request = requestType.request else {
            return ["Invalid request for \(target.baseURL.path)\(target.path)"]
        }
        
        var allHeaders = requestType.sessionHeaders
        allHeaders.merge(request.allHTTPHeaderFields ?? [:]) { $1 }
        
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
    
    private func responseItems(result: Result<Response, MoyaError>, target: TargetType) -> [String] {
        switch result {
        case .success(let response):
            return successResponseItems(response: response, target: target)
        case .failure(let error):
            return errorResponseItems(error: error, target: target)
        }
    }
    
    private func successResponseItems(response: Response, target: TargetType) -> [String] {
        return [
            "URL: \(response.response?.url?.absoluteString ?? (target.baseURL.path + target.path))",
            "Body:\n\(response.data.formattedJSONString)",
        ]
    }
    
    private func errorResponseItems(error: MoyaError, target: TargetType) -> [String] {
        if let response = error.response {
            return successResponseItems(response: response, target: target)
        } else {
            return ["Error while calling \(target.baseURL.path)\(target.path)"]
        }
    }
}
