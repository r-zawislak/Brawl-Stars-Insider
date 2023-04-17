//
//  MapDetailsViewModel.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 14/04/2023.
//

import Combine

final class MapDetailsViewModel: ObservableObject {
    let map: Event.Map
    let stats: [Event.Map.Stat]
    
    init(map: Event.Map) {
        self.map = map
        
        stats = StatsSorter().sortedStats(map.stats ?? [])
    }
}
