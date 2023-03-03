//
//  EventRowViewModel.swift
//  Brawl Stars Insider
//
//  Created by Rajmund Zawiślak on 17/02/2023.
//
import Combine
import Foundation

final class EventRowViewModel: ObservableObject {
    
    @Published var recommended: [Event.Map.Stat] = []
    @Published var eventEndsInString = ""
    
    private let winRateWeight = 0.1
    private let useRateWeight = 0.9
    private let recommendedStatsCount = 5
    private let event: Event
    private var timeToEndEvent: TimeInterval
    
    private let dateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        return formatter
    }()
    
    init(event: Event) {
        self.event = event
        timeToEndEvent = event.endTime.timeIntervalSince(.now)
        
        updateRecommendedBrawlers()
        updateEventEndsInString()
    }
    
    private func updateEventEndsInString() {
        eventEndsInString = "Ends in \(dateComponentsFormatter.string(from: timeToEndEvent) ?? "")"
    }
    
    private func updateRecommendedBrawlers() {
        let filteredStats = event.map.stats
            .filter { stat in
                stat.winRate > 50 && stat.useRate > 2
            }
        
        let weightSum = useRateWeight + winRateWeight
  
        let sortedStats = filteredStats.sorted { lhs, rhs in
            let lhsWeight = lhs.useRate * useRateWeight + lhs.winRate * winRateWeight / weightSum
            let rhsWeight = rhs.useRate * useRateWeight + rhs.winRate * winRateWeight / weightSum

            return lhsWeight > rhsWeight
        }
        
        let recommendedStatsCount = sortedStats.count > 4 ? recommendedStatsCount : sortedStats.count
        
//        print("\nMap: \(event.map.name)\n")
//        
//        sortedStats.forEach {
//            print("ID: \($0.brawler)")
//            print("Win: \($0.winRate)")
//            print("Use: \($0.useRate)")
//        }
        recommended = Array(sortedStats.prefix(upTo: recommendedStatsCount))
    }
}
