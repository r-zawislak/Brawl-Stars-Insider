//
//  EventsViewModel.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/02/2023.
//

import Combine
import Foundation

final class EventsViewModel: ObservableObject {
    
    @MainActor @Published var events: [Event] = []
    
    @Dependency(\.brawlifyProvider) var provider
    
    func fetchEvents() async throws {
        guard await events.isEmpty else {
            return
        }
        
        let events = try await provider.request(.getEvents, responseType: GetEventsResponse.self).active.filter {
            // Ignore challenges for now
            $0.slot.background == nil
        }

        await MainActor.run {
            self.events = events
        }
    }
}
