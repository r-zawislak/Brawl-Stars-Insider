//
//  Provider.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 04/03/2023.
//

import Alamofire
import Foundation

class Provider<T: Endpoint> {
    private let session: Session
    private let useMockData: Bool
    private let decoder: JSONDecoder
    private let logger = Logger()
    
    init(decoder: JSONDecoder = .init(), useMockData: Bool = isRunningPreview) {
        session = Session(eventMonitors: [logger])
        self.useMockData = useMockData
        self.decoder = decoder
    }
    
    func request<U: Decodable>(_ endpoint: T, responseType: U.Type) async throws -> U {
        if let mockData = endpoint.mockData, useMockData {
            let decodedData = try decoder.decode(U.self, from: mockData)
            return decodedData
        } else {
            return try await withCheckedThrowingContinuation { continuation in
                let request = session.request(
                    url(for: endpoint),
                    method: endpoint.method,
                    parameters: endpoint.parameters,
                    headers: endpoint.headers
                )
                
                request.responseDecodable(of: U.self, decoder: decoder) { response in
                    switch response.result {
                    case .success(let value):
                        DispatchQueue.main.async {
                            continuation.resume(returning: value)
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            continuation.resume(throwing: error)
                        }
                    }
                }
            }
        }
    }

    private func url(for endpoint: T) -> URL {
        endpoint.baseURL.appendingPathComponent(endpoint.path)
    }
}
