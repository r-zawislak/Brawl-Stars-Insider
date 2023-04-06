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
    
    private let filteredWinRates = 50.0
    private let filteredUseRates = 2.0
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
        let dateString = dateComponentsFormatter.string(from: timeToEndEvent) ?? ""
        eventEndsInString = Localizations.Events.Row.EndsIn.localized(p0: dateString)
    }
    
    private func updateRecommendedBrawlers() {
        let weightSum = useRateWeight + winRateWeight
  
        let sortedStats = event.map.stats?.sorted { lhs, rhs in
            let lhsWeight = lhs.useRate * useRateWeight + lhs.winRate * winRateWeight / weightSum
            let rhsWeight = rhs.useRate * useRateWeight + rhs.winRate * winRateWeight / weightSum

            return lhsWeight > rhsWeight
        } ?? []
        
        let recommendedStatsCount = min(sortedStats.count, recommendedStatsCount)
        
        recommended = Array(sortedStats.prefix(recommendedStatsCount))
    }
}
