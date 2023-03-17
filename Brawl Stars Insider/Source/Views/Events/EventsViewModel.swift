//
//  EventsViewModel.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Combine
import Foundation

final class EventsViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    
    private let provider = Provider<BrawlifyEndpoint>(decoder: .brawlifyDecoder)
    
    func fetchEvents() async throws {
        guard events.isEmpty else {
            return
        }
        
        let events = try await provider.request(.getEvents, responseType: GetEventsResponse.self).active.filter {
            // Ignore challenges for now
            $0.slot.background == nil
        }

        DispatchQueue.main.async {
            self.events = events
        }
    }
}
