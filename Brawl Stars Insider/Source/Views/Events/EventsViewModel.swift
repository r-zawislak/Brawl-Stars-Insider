//
//  EventsViewModel.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Combine
import Moya
import CombineMoya
import Foundation

final class EventsViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    
    private let provider = MoyaProvider<BrawlifyEndpoint>()
    
    func fetchEvents() async throws {
        events = try await provider.requestPublisher(.getEvents)
            .map(GetEventsResponse.self, using: .brawlifyDecoder)
            .async()
            .active
    }
}
