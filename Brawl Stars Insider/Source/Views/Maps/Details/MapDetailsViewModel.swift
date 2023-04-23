//
//  MapDetailsViewModel.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/04/2023.
//

import Combine

final class MapDetailsViewModel: ObservableObject {
    let map: Event.Map
    
    @MainActor @Published var stats: [Event.Map.Stat] = []
    
    @Dependency(\.brawlifyProvider) var provider
    
    init(map: Event.Map) {
        self.map = map
    }
    
    func fetchDetails() async throws {
        let map = try await provider.request(.getMapDetails(id: map.id), responseType: Event.Map.self)
        
        await MainActor.run {
            stats = StatsSorter().sortedStats(map.stats ?? [])
        }
    }
}
