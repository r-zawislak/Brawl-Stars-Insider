//
//  StatsSorter.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 16/04/2023.
//

import Foundation

final class StatsSorter {
    
    let filteredWinRates = 50.0
    let filteredUseRates = 2.0
    let winRateWeight = 0.1
    let useRateWeight = 0.9
    
    init() { }
    
    func sortedStats(_ stats: [Event.Map.Stat], maxCount: Int? = nil) -> [Event.Map.Stat] {
        let weightSum = useRateWeight + winRateWeight
  
        let sortedStats = stats.sorted { lhs, rhs in
            let lhsWeight = lhs.useRate * useRateWeight + lhs.winRate * winRateWeight / weightSum
            let rhsWeight = rhs.useRate * useRateWeight + rhs.winRate * winRateWeight / weightSum

            return lhsWeight > rhsWeight
        }
        
        let statsCount = min(sortedStats.count, maxCount ?? sortedStats.count)
        
        return Array(sortedStats.prefix(statsCount))
    }
}
